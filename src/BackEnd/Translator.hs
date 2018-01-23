{-
  "Compiler Construction" course @ MIMUW.
  `Latte` language static code analyzer.

  Author: Michał Preibisch   < mp347207@students.mimuw.edu.pl >
  Lecturer: mgr Artur Zaroda

  Translator implementation.

  This module is responsible for generating assembly code.
-}
module Translator where

import LatteTypes
import ErrM
import ParLatte
import StringExtractor(getAllStrings)
import System.Environment
import System.IO
import Control.Monad.State
import Control.Monad.Trans.Except
import Data.Maybe
import qualified Data.Map as M
import qualified Data.List as L
import qualified Data.Set as S

{-    ============================================================
      =================   DATA STRUCTURES      ===================
      ============================================================  -}

-- Binary operation wrapper
data BinOp = Mul MulOp | Add AddOp | Rel RelOp

-- Data type for assembly code instructions
-- Explanation for InstrBlock: Some higher-level instructions are abstract and
-- consist of multiple assembly instructions, hence I group them together
data Instr = Indent String | NoIndent String | InstrBlock [Instr] | EmptyLn | Noop deriving Eq

type Label = String

-- Variables environment.
type VarEnv = M.Map Ident VarType

type FunRetEnv = M.Map Ident Type

type ClsEnv = M.Map Ident ClassType

type StrEnv = M.Map String Label

-- Class functions environment.
type ClsFunEnv = M.Map Ident ClsFunType

data ClassType = ClassType {
  parent :: Maybe Ident,
  venv :: VarEnv,
  fenv :: ClsFunEnv,
  vmcount :: Int, -- Virtual methods count
  align :: Int
} deriving Show

data VarType = VarType {
  vtype :: Type,
  offset :: Int
} deriving Show

type VirtualID = Int

data ClsFunType = ClsFunType {
  retType :: Type,
  vid :: Maybe VirtualID,
  clsName :: Ident
} deriving Show

instance Show Instr where
  show (Indent str) = "    " ++ str
  show (NoIndent str) = str
  show (InstrBlock instrs) = rmDoubleLF $ unlines [show i | i <- instrs]
  show EmptyLn = ""

-- Monad for code Translation. Last 3 elements are stack sizes sizes and label number
type TR a = State (VarEnv, FunRetEnv, ClsEnv, StrEnv, Int, Int, Int) a

rmDoubleLF :: String -> String
rmDoubleLF [] = []
rmDoubleLF [h] = [h]
rmDoubleLF ('\n':'\n':rest) = '\n':rmDoubleLF rest
rmDoubleLF (h:t) = h:rmDoubleLF t

newVar :: Type -> Int -> VarType
newVar t off = VarType {
  vtype = t,
  offset = off
}

newClass :: Maybe Ident -> VarEnv -> ClsFunEnv -> Int -> Int -> ClassType
newClass parent' venv' fenv' vmcount' align' = ClassType {
  parent = parent',
  venv = venv',
  fenv = fenv',
  vmcount = vmcount',
  align = align'
}

initState = (M.empty, M.empty, M.empty, M.empty, 0, 0, 0)

{-    ============================================================
      =================  UTILITIES - TYPES     ===================
      ============================================================  -}

getExprType :: Expr -> TR Type
getExprType (EVar ident) = getVarType ident

getExprType (ELitInt _) = return Int

getExprType ELitTrue = return Bool

getExprType ELitFalse = return Bool

getExprType (ENewCls t@(ClsType ident)) = return t

getExprType (ENewArr t _) = return (ArrType t)

getExprType (EApp ident _) = getFunRetType ident

getExprType (EPropApp expr ident _) = do
  (ClsType t) <- getExprType expr
  clt <- getClassType t
  return $ retType $ case M.lookup ident (fenv clt) of
    (Just x) -> x
    Nothing -> error "Fun in cls fenv lookup!"

getExprType (EProp expr ident) = do
  t <- getExprType expr
  case t of
    (ClsType name) -> do
      clt <- getClassType name
      return $ vtype $ case M.lookup ident (venv clt) of
        (Just x) -> x
        Nothing -> error "EProp lookup in getExprType (EProp ...)"
    (ArrType _) -> return Int  -- The only property is "length", already checked by StaticChecker

getExprType (EArrGet e _) = do
  (ArrType t) <- getExprType e
  return t

getExprType (ENullCast ident) = return $ ClsType ident

getExprType (EString _) = return Str

getExprType (Neg _) = return Int

getExprType (Not _) = return Bool

getExprType EMul {} = return Int

getExprType (EAdd e Plus _) = getExprType e

getExprType (EAdd e Minus _) = return Int

getExprType ERel {} = return Bool

getExprType EAnd {} = return Bool

getExprType EOr {} = return Bool

getVarType :: Ident -> TR Type
getVarType ident = do
  (venv, _, _, _, _, _, _) <- get
  if M.member ident venv then
    return $ vtype $ venv M.! ident
  else
    getExprType (EProp (EVar (Ident "self")) ident)

getFunRetType :: Ident -> TR Type
getFunRetType ident = do
  (_, fenv, _, _, _, _, _) <- get
  return $ case M.lookup ident fenv of
    (Just t) -> t
    Nothing -> error "funRetType lookup!"

getClassType :: Ident -> TR ClassType
getClassType ident = do
  (_, _, cenv, _, _, _, _) <- get
  return $ cenv M.! ident

getTypeSize :: Type -> Int
getTypeSize Int = 4
getTypeSize Str = 4
getTypeSize Bool = 4
getTypeSize (ArrType _) = 8
getTypeSize (ClsType _) = 4
getTypeSize _ = 0

fromIdent :: Ident -> String
fromIdent (Ident str) = str

iterIdent :: Ident -> Ident
iterIdent (Ident str) = Ident (str ++ "__iter")

getVTableName :: Ident -> String
getVTableName (Ident str) = "." ++ str ++ "VTable"

{-    ============================================================
      ================  UTILITIES: ENV, STORAGE  =================
      ============================================================  -}

-- Returns nextLabel ; SIDE EFFECT : increments nextLabel
incLabel :: TR Int
incLabel = do
  (env, fenv, cenv, senv, mins, maxt, nextLabel) <- get
  put (env, fenv, cenv, senv, mins, maxt, nextLabel + 1)
  return nextLabel

getLabel :: TR Int
getLabel = do
  (_, _, _, _, _, _, nextLabel) <- get
  return nextLabel

-- Returns next three labels ; SIDE EFFECT : increments nextLabel by 3
getTrueFalseExitLabels :: TR (Int, Int, Int)
getTrueFalseExitLabels = do
  trueLabel <- incLabel
  falseLabel <- incLabel
  exitLabel <- incLabel
  return (trueLabel, falseLabel, exitLabel)

getStringStoreInstr :: String -> TR Instr
getStringStoreInstr str = do
  strLabel <- getStrLabel str
  return $ InstrBlock [NoIndent (strLabel ++ ":"), NoIndent $ ".string " ++ show str]

registerString :: String -> Int -> TR ()
registerString str labelNo = do
  (venv, fenv, cenv, senv, x, y, nextLabel) <- get
  void $ put (venv, fenv, cenv, M.insert str (makeStrLabel labelNo) senv, x, y, nextLabel)

makeStrLabel :: Int -> Label
makeStrLabel labelNo = ".LC" ++ show labelNo

getStrLabel :: String -> TR Label
getStrLabel str = do
  (_, _, _, senv, _, _, _) <- get
  return $ case M.lookup str senv of
    (Just l) -> l
    Nothing -> error $ "Str lookup error " ++ str

getVarOffset :: Ident -> TR Int
getVarOffset ident = do
  (venv, _, _, _, _, _, _) <- get
  return $ offset $ case M.lookup ident venv of
    (Just v) -> v
    Nothing -> error $ "Offset lookup error " ++ show ident


-- Will register/store all strings that occurred in program
registerAllStrings :: Program -> TR Instr
registerAllStrings prog = do
  let allStrings = getAllStrings prog
  foldM_ (\labelNo str -> do
    registerString str labelNo
    return (labelNo + 1)) 0 allStrings
  res <- mapM getStringStoreInstr allStrings
  return $ InstrBlock res

fromItemIdent :: Item -> TR Ident
fromItemIdent (NoInit ident) = return ident
fromItemIdent (Init ident _ ) = return ident

defaultValueExpr :: Type -> Expr
defaultValueExpr t = case t of
    Str          -> EString ""             -- Empty string
    (ArrType at) -> ENewArr at (ELitInt 0) -- Array of size 0
    _            -> ELitInt 0              -- 0  (value of int or bool (false))

declareVar :: Type -> Item -> Int -> TR (Instr, Int)
declareVar t item size = do
  initInstrs <- transExpr $ case item of
    (NoInit _) -> defaultValueExpr t
    (Init _ expr) -> expr
  ident <- fromItemIdent item
  let varSize = getTypeSize t
  (venv, fenv, cenv, senv, minSize, maxTmp, label) <- get
  put (M.insert ident (newVar t (size - varSize)) venv, fenv, cenv, senv,
    min (size - varSize) minSize, maxTmp, label)
  varInstrStr <- transVarStr ident
  case t of
    (ArrType _) -> do
      sizeInstr <- transVarStr' ident 4
      return (InstrBlock [initInstrs, popl varInstrStr, popl sizeInstr], size - varSize)
    _ -> return (InstrBlock [initInstrs, popl varInstrStr], size - varSize)

declareVars :: Type -> [Item] -> Int -> TR (Instr, Int)
declareVars t (item:items) size = do
  (instrs, newSize) <- declareVar t item size
  (instrsRest, endSize) <- declareVars t items newSize
  return (InstrBlock [instrs, instrsRest], endSize)
declareVars _ [] size = return (EmptyLn, size)


-- Instrucions for memory allocation on stack for variables from list of statements
allocateVariables :: [Stmt] -> TR Instr
allocateVariables stmts = do
  varSize <- allocVarsSize 0 stmts -- varSize bytes needs to be subtracted fromm curr stack pointer
  return $ subl ("$" ++ show (-varSize)) esp

allocVarsSize :: Int -> [Stmt] -> TR Int
allocVarsSize size (stmt:stmts) = case stmt of
  (Decl t items) -> do
    (_, newSize) <- declareVars t items size
    allocVarsSize newSize stmts
  (Cond _ s) -> allocVarsSize size (s:stmts)
  (CondElse _ s1 s2) -> allocVarsSize size (s2:s2:stmts)
  (BStmt (Block rest)) -> do
    newSize <- allocVarsSize size rest
    allocVarsSize newSize stmts
  (While _ s) -> allocVarsSize size (s:stmts)
  (For t ident _ s) -> do
    (_, newSize) <- declareVars t [NoInit ident] size
    (_, maxSize) <- declareVars Int [NoInit (Ident "noob")] newSize
    allocVarsSize maxSize (s:stmts)
  _ -> allocVarsSize size stmts
allocVarsSize size [] = return size


createVTables :: TR Instr
createVTables = do
  (_, _, cenv, _, _, _, _) <- get
  instrs <- mapM createVTable $ M.keys cenv
  return $ InstrBlock instrs


createVTable :: Ident -> TR Instr
createVTable ident = do
  clt <- getClassType ident
  let virt = L.sort $ map toVirtual [(fName, fType) | (fName, fType) <- M.toList (fenv clt), isJust (vid fType)]
  let vArr = foldl (\acc (_, s) -> acc ++ "," ++ s) "" virt
  if not $ null vArr then
    return $ NoIndent $ getVTableName ident ++ ": .int " ++ tail vArr  -- "," dropped via tail
   else
    return EmptyLn

toVirtual (fName, fType) = (fromJust (vid fType), fromIdent (clsName fType) ++ "$" ++ fromIdent fName)

{-    ============================================================
      =============  UTILITIES: INSTRUCTIONS (x86) ===============
      ============================================================  -}

showLabel :: Int -> String
showLabel num = ".L" ++ show num

showLabel' :: Int -> String
showLabel' num = ".L" ++ show num ++ ":"

getLabelInstr :: Int -> Instr
getLabelInstr num = NoIndent $ showLabel' num

pushl :: String -> Instr
pushl str = Indent $ "pushl   " ++ str

popl :: String -> Instr
popl str = Indent $ "popl    " ++ str

movl :: String -> String -> Instr
movl src dest = Indent $ "movl    " ++ src ++ ", " ++ dest

testl :: String -> String -> Instr
testl src dst = Indent $ "testl   " ++ src ++ ", " ++ dst

jmpLabel :: Int -> Instr
jmpLabel label = Indent $ "jmp " ++ showLabel label

jmpOpLabel :: RelOp -> Int -> Instr
jmpOpLabel op label = Indent $ jmp op ++ showLabel label

call :: String -> Instr
call str = Indent $ "call    " ++ str

cmpl :: String -> String -> Instr
cmpl str1 str2 = Indent $ "cmpl    " ++ str1 ++ ", " ++ str2

jmp :: RelOp -> String
jmp op = case op of
  LTH -> "jge "
  LE -> "jg  "
  GTH -> "jle "
  GE -> "jl  "
  EQU -> "jne "
  NE -> "je  "

jmpNz :: Int -> Instr
jmpNz labelNo = Indent $ "jnz  " ++ showLabel labelNo

neg :: String -> Instr
neg reg = Indent $ "neg " ++ reg

-- Registry names macros
eax = "%eax"
ebx = "%ebx"
ecx = "%ecx"
edx = "%edx"
ebp = "%ebp"
esp = "%esp"

-- Arithmetic instructions macros
addl :: String -> String -> Instr
addl src dest = Indent $ "addl    " ++ src ++ ", " ++ dest

subl :: String -> String -> Instr
subl src dest = Indent $ "subl    " ++ src ++ ", " ++ dest

imul :: String -> String -> Instr
imul src dest = Indent $ "imul    " ++ src ++ ", " ++ dest

idiv :: String -> Instr
idiv src = Indent $ "idiv    " ++ src

sar :: String -> String -> Instr
sar src dest = Indent $ "sar    " ++ src ++ ", " ++ dest

leal :: String -> String -> Instr
leal src dest = Indent $ "leal    " ++ src ++ ", " ++ dest

calloc :: String
calloc = "calloc"

incl :: String -> Instr
incl src = Indent $ "incl    " ++ src

decl :: String -> Instr
decl src = Indent $ "decl    " ++ src

leave :: Instr
leave = Indent "leave"

ret :: Instr
ret = Indent "ret"

entry :: String
entry = ".globl main\n\n"

{-    ============================================================
      ================ TRANSLATION: EXPRESSIONS  =================

      IMPORTANT NOTE: After translating (evaluating) an expression,
      it's result is pushed onto stack, via 'pushl' assembly instrucion.

      Every non-array type have size of 4 bytes and in that case only one item
      is pushed to stack as a result of single expression. In case of array
      (but not array element of primmitive type), two items are pushed onto stack,
      hence two pops into registers are needed.
      ============================================================  -}

transExpr (EVar ident) = do
  varType <- getVarType ident
  case varType of
    ArrType _ -> do
      varInstr <- transVar ident
      sizeInstr <- transVar' ident 4 -- Offset for array's size is 4
      return $ InstrBlock [sizeInstr, varInstr] -- For array 2 items are pushed onto stack: ptr and size
    _ -> transVar ident

transExpr (ELitInt i) = return $ pushl $ "$" ++ show i

transExpr ELitTrue = return $ pushl "$1"

transExpr ELitFalse = return $ pushl "$0"

transExpr (ENewCls (ClsType ident)) = do
  clt <- getClassType ident
  hasVtable <- hasVTable ident
  let vPtr = if hasVtable then "$" ++ getVTableName ident else "$0"
  return $ InstrBlock [pushl "$4", pushl $ "$" ++ show (align clt), call calloc, popl ebx, popl ebx,
    movl vPtr "(%eax)", pushl eax]

transExpr (ENewArr t expr) = do
  instrs <- transExpr expr
  return $ InstrBlock [pushl $ "$" ++ show (getTypeSize t), instrs, call calloc,
    popl ebx, popl ecx, pushl ebx, pushl eax]

transExpr (EApp ident exprs) = do
  retType <- getFunRetType ident
  transFunApplication (fromIdent ident) exprs retType

transExpr (EPropApp lvalexpr ident exprs ) = do
  lvalInstr <- transLeftValue lvalexpr
  (ClsType cident) <- getExprType lvalexpr
  clt <- getClassType cident
  let (ClsFunType retType vid clsName) = case M.lookup ident (fenv clt) of
                                        (Just x) -> x
                                        Nothing -> error "FunType in clsFenv lookup!"
  let popPush = if retType /= Void then [popl ebx, popl ebx, pushl eax] else [popl ebx]
  case vid of
    (Just virtID) -> do
      funAppInstrs <- transFunApplication ("*" ++ show (4 * virtID) ++ "(%edx)") exprs retType
      return $ InstrBlock [lvalInstr, popl eax, movl "(%eax)" ebx, movl "(%ebx)" edx, pushl "(%eax)", funAppInstrs, InstrBlock popPush]
    Nothing -> do
      funAppInstrs <- transFunApplication (fromIdent clsName ++ "$" ++ fromIdent ident) exprs retType
      return $ InstrBlock [lvalInstr, popl eax, pushl "(%eax)", funAppInstrs, InstrBlock popPush]

transExpr e@(EProp expr ident) = do
  t <- getExprType expr
  instrs <- transLeftValue expr
  case t of
    (ArrType _) -> return $ InstrBlock [instrs, popl eax, pushl "4(%eax)"] -- Arr length has offset 4
    _ -> do
      lvalInstr <- transLeftValue e
      return $ InstrBlock [lvalInstr, popl eax, pushl "(%eax)"]

transExpr e@(EArrGet expr1 expr2) = do
  arrInstr <- transLeftValue e
  return $ InstrBlock [arrInstr, popl eax, pushl "(%eax)"]

transExpr (ENullCast ident) = return $ pushl "$0" -- Null is just a 0x0

transExpr (EString str) = do
  labelString <- getStrLabel str
  return $ pushl $ "$" ++ labelString

transExpr (Neg expr) = do
  instrs <- transExpr expr
  return $ InstrBlock [instrs, popl eax, neg eax, pushl eax]

transExpr (EMul expr1 mulOp expr2) = transBinOp expr1 (Mul mulOp) expr2

transExpr (EAdd expr1 addOp expr2) = transBinOp expr1 (Add addOp) expr2

transExpr (ERel expr1 relOp expr2) = transBinOp expr1 (Rel relOp) expr2

transExpr e@(EAnd expr1 expr2) = transBoolExpr e

transExpr e@(EOr expr1 expr2) = transBoolExpr e

transExpr e@(Not expr) = transBoolExpr e


{-    ============================================================
      =========  TRANSLATION: EXPRESSIONS - utilities  ===========
      ============================================================  -}


{- Translation of binary operation
  Because translating expressions results in pushing result to
  a stack, when performing binary operation all we have to do
  is to pop operands from stack into registers and return a proper
  InstrBlock. Approach is similar to JVM stack-based machine. -}
transBinOp :: Expr -> BinOp -> Expr -> TR Instr
transBinOp expr1 binOp expr2 = do
  exprT <- getExprType expr1
  if exprT == Str then
    transStrConcat expr1 expr2
  else
    transBinNumOp expr1 binOp expr2

-- Addition of strings (other operations are forbidden) via external funcion call
transStrConcat :: Expr -> Expr -> TR Instr
transStrConcat expr1 expr2 = do
  instr1 <- transExpr expr1
  instr2 <- transExpr expr2
  return $ InstrBlock [instr1, instr2, reverse2Args, call addStrings,
    popl ebx, popl ebx, pushl eax]

-- Reverses order of 2 top elements on stack
reverse2Args :: Instr
reverse2Args = InstrBlock [popl ebx, popl ecx, pushl ebx, pushl ecx]

-- Binary operation between two numerical arguments (ints)
transBinNumOp :: Expr -> BinOp -> Expr -> TR Instr
transBinNumOp expr1 binOp expr2 = do
  instrs1 <- transExpr expr1
  instrs2 <- transExpr expr2
  binOpInstr <- transOp binOp
  return $ InstrBlock [instrs1, instrs2, binOpInstr]

-- Translating binary operation into asm instructions, assuming that operands are on stack
transOp :: BinOp -> TR Instr
transOp (Mul mulOp) = case mulOp of
  Times -> return $ InstrBlock [popl eax, popl ebx, imul ebx eax, pushl eax]
  Div -> return $ InstrBlock [divOpInstr, pushl eax] -- quotient stored in eax
  Mod -> return $ InstrBlock [divOpInstr, pushl edx] -- remainder stored in edx
  where  -- sar (shift arithmetic right) is to store contents of number to be divided as (EDX:EAX)
    divOpInstr = InstrBlock [popl ebx, popl eax, movl eax edx, sar "$31" edx, idiv ebx]

transOp (Add addOp) = return $ case addOp of
  Plus -> InstrBlock [popl eax, popl ebx, addl ebx eax, pushl eax]
  Minus -> InstrBlock [popl eax, popl ebx, subl eax ebx, pushl ebx]

transOp (Rel relOp) = do
  labelFalseNo <- incLabel
  labelTrueNo <- incLabel
  return $ InstrBlock [popl eax, cmpl eax "0(%esp)", jmpOpLabel relOp labelFalseNo,
            pushl "$1", jmpLabel labelTrueNo, getLabelInstr labelFalseNo, pushl "$0",
            getLabelInstr labelTrueNo]

transBoolExpr :: Expr -> TR Instr
transBoolExpr expr = do
  (labelTrueNo, labelFalseNo, labelExitNo) <- getTrueFalseExitLabels
  instrs <- transBoolExprHelper expr labelTrueNo labelFalseNo
  return $ InstrBlock [instrs, getLabelInstr labelTrueNo, pushl "$1", jmpLabel labelExitNo,
          getLabelInstr labelFalseNo, pushl "$0", getLabelInstr labelExitNo]

transBoolExprHelper :: Expr -> Int -> Int -> TR Instr
transBoolExprHelper e@(ERel expr1 op expr2) labelTrueNo labelFalseNo = do
  instrs <- transExpr e
  return $ InstrBlock [instrs, popl eax, testl eax eax, jmpNz labelTrueNo,
    jmpLabel labelFalseNo]

transBoolExprHelper (EAnd expr1 expr2) labelTrueNo labelFalseNo = do
  labelIndirectNo <- incLabel
  instrs1 <- transBoolExprHelper expr1 labelIndirectNo labelFalseNo
  instrs2 <- transBoolExprHelper expr2 labelTrueNo labelFalseNo
  return $ InstrBlock [instrs1, getLabelInstr labelIndirectNo, instrs2]

transBoolExprHelper (EOr expr1 expr2) labelTrueNo labelFalseNo = do
  labelIndirectNo <- incLabel
  instrs1 <- transBoolExprHelper expr1 labelTrueNo labelIndirectNo
  instrs2 <- transBoolExprHelper expr2 labelTrueNo labelFalseNo
  return $ InstrBlock [instrs1, getLabelInstr labelIndirectNo, instrs2]

transBoolExprHelper (Not expr) labelTrueNo labelFalseNo =
  transBoolExprHelper expr labelFalseNo labelTrueNo

transBoolExprHelper expr labelTrueNo labelFalseNo = do
  instrs <- transExpr expr
  return $ InstrBlock [instrs, popl eax, testl eax eax, jmpNz labelTrueNo,
    jmpLabel labelFalseNo]

transFunApplication ident args retType = do
  argsInstrs <- mapM transExpr args
  argsSize <- calculateArgsSize args
  clearArgsInstr <- clearArgsFromStack argsSize
  let funAppInstrs = InstrBlock [InstrBlock argsInstrs, call ident, clearArgsInstr] in
    case retType of
      ArrType _ -> return $ InstrBlock [funAppInstrs, pushl edx, pushl eax] -- Pointer to array and array size are pushed to the stack
      Void -> return funAppInstrs
      _ -> return $ InstrBlock [funAppInstrs, pushl eax]  -- Every type has 4 bytes except array

clearArgsFromStack :: Int -> TR Instr
clearArgsFromStack argsSize = return $ InstrBlock $ replicate argsSize $ popl ebx

-- Calculation of arguments' size in "4-byte" chunks
-- E.g:  If "int x" is the only argument, result is 1 since it's 4-bytes.
calculateArgsSize :: [Expr] -> TR Int
calculateArgsSize [] = return 0
calculateArgsSize (expr:exprs) = do
  t <- getExprType expr
  rest <- calculateArgsSize exprs
  return $ (case t of
    ArrType _ -> 2
    _         -> 1) + rest

-- Results in pushing variable onto stack
transVar' :: Ident -> Int -> TR Instr
transVar' ident offset = do
  (venv, _, _, _, _, _, _) <- get
  if M.member ident venv then do
    varInstr <- transVarStr' ident offset
    return $ pushl varInstr
  else
    transExpr (EProp (EVar (Ident "self")) ident)

-- Results in pushing variable onto stack
transVar ident = transVar' ident 0

transVarStr' :: Ident -> Int -> TR String
transVarStr' ident offset = do
  varOffset <- getVarOffset ident
  return $ show (varOffset + offset) ++ "(%ebp)"

transVarStr ident = transVarStr' ident 0

-- SRCH
transLeftValue :: Expr -> TR Instr
transLeftValue (EVar ident) = do
  (venv, _, _, _, _, _, _) <- get
  if M.member ident venv then do
    varInstrStr <- transVarStr ident
    return $ InstrBlock [leal varInstrStr eax, pushl eax]
  else
    transLeftValue $ EProp (EVar $ Ident "self") ident

transLeftValue (EArrGet arr idx) = do
  lvalInstr <- transLeftValue arr
  idxInstr <- transExpr idx
  return $ InstrBlock [lvalInstr, idxInstr, popl eax, popl ebx, movl "(%ebx)" ecx,
                    leal "(%ecx, %eax, 4)" ebx, pushl ebx]
transLeftValue e@(EProp lval ident) = do
  (ClsType cident) <- getExprType lval
  lvalInstr <- transLeftValue lval
  clt <- getClassType cident
  let varOffset = offset $ case M.lookup ident (venv clt) of
                  (Just x) -> x
                  Nothing -> error "Property lookup in trans lval!"
  return $ InstrBlock [lvalInstr, popl eax, movl "(%eax)" ebx,
            leal (show varOffset ++ "(%ebx)") eax, pushl eax]
transLeftValue fApp@EApp {} = transExpr fApp

leaveFunction :: Instr
leaveFunction = InstrBlock [leave, ret]

prologFunction :: Instr
prologFunction = InstrBlock [pushl ebp, movl esp ebp]

self :: Ident
self = Ident "self"

hasVTable ident = do
  clt <- getClassType ident
  return $ not $ null $ filter (\(ClsFunType _ v _) -> isJust v) $ M.elems (fenv clt)

{-    ============================================================
      ================  TRANSLATION: STATEMENTS  =================
      ============================================================  -}

transStmt :: Stmt -> TR Instr
transStmt Empty = return EmptyLn

transStmt (BStmt (Block stmts)) = do
  (env, fenv, cenv, senv, minSize, maxTmp, _) <- get
  blockInstrs <- mapM transStmt stmts
  label <- getLabel
  put (env, fenv, cenv, senv, minSize, maxTmp, label)
  return $ InstrBlock blockInstrs

transStmt (Decl t items) = do
  (_, _, _, _, size, _, _) <- get
  (instrs, _ ) <- declareVars t items size
  return instrs

transStmt (Ass expr1 expr2) = do
  t <- getExprType expr2
  expr1Instr <- transLeftValue expr1
  expr2Instr <- transExpr expr2
  case t of
    (ArrType _) -> return $ InstrBlock [expr1Instr, expr2Instr, popl eax,
      popl ebx, popl ecx, movl eax "(%ecx)", addl "$4" ecx, movl ebx "(%ecx)"]
    _ -> return $ InstrBlock [expr1Instr, expr2Instr, popl eax, popl ebx, movl eax "(%ebx)"]

transStmt (Incr expr) = do
  instr <- transLeftValue expr
  return $ InstrBlock [instr, popl eax, incl "(%eax)"]

transStmt (Decr expr) = do
  instr <- transLeftValue expr
  return $ InstrBlock [instr, popl eax, decl "(%eax)"]

transStmt (Ret expr) = do
  t <- getExprType expr
  instr <- transExpr expr
  case t of
    (ArrType _) -> return $ InstrBlock [instr, popl eax, popl edx, leaveFunction]
    _ -> return $ InstrBlock [instr, popl eax, leaveFunction]

transStmt VRet = return leaveFunction

transStmt (Cond expr stmt) = do
  labelTrueNo <- incLabel
  labelFalseNo <- incLabel
  exprInstr <- transBoolExprHelper expr labelTrueNo labelFalseNo
  stmtInstrs <- transStmt (BStmt (Block [stmt]))
  return $ InstrBlock [exprInstr, getLabelInstr labelTrueNo,
    stmtInstrs, getLabelInstr labelFalseNo]

transStmt (CondElse expr stmt1 stmt2) = do
  (labelTrueNo, labelFalseNo, labelExitNo) <- getTrueFalseExitLabels
  exprInstr <- transBoolExprHelper expr labelTrueNo labelFalseNo
  stmt1Instrs <- transStmt (BStmt (Block [stmt1]))
  stmt2Instrs <- transStmt (BStmt (Block [stmt2]))
  return $ InstrBlock [exprInstr, getLabelInstr labelTrueNo, stmt1Instrs,
   jmpLabel labelExitNo, getLabelInstr labelFalseNo, stmt2Instrs, getLabelInstr labelExitNo]

transStmt (While expr stmt) = do
  (labelCondNo, labelBodyNo, labelExitNo) <- getTrueFalseExitLabels
  exprInstr <- transBoolExprHelper expr labelBodyNo labelExitNo
  stmtInstr <- transStmt (BStmt (Block [stmt]))
  return $ InstrBlock [getLabelInstr labelCondNo, exprInstr, getLabelInstr labelBodyNo,
    stmtInstr, jmpLabel labelCondNo, getLabelInstr labelExitNo]

transStmt (SExp expr) = transExpr expr

transStmt (For t ident expr stmt) = do
  (venv, fenv, cenv, senv, minSize, maxTmp, labelNo) <- get
  put (venv, fenv, cenv, senv, minSize, maxTmp + 1, labelNo)
  instrs <- transStmt $ getForEachBlock expr t ident stmt
  nextLabelNo <- getLabel
  put (venv, fenv, cenv, senv, minSize, maxTmp, nextLabelNo)
  return instrs

getForEachBlock :: Expr -> Type -> Ident -> Stmt -> Stmt
getForEachBlock array t ident stmt = let iter = iterIdent ident in BStmt $ Block [
  Decl Int [Init iter (ELitInt 0)],                                             -- int i = 0
  While (ERel (EVar iter) LTH (EProp array (Ident "length"))) $ BStmt $ Block [ -- while i < a.length
    Decl t [Init ident (EArrGet array (EVar iter))],                            -- ident = a[i]
    stmt,                                                                       -- code
    Incr (EVar iter)                                                            -- i++
    ]
  ]

{-    ============================================================
      ================ TRANSLATION: TOP LEVEL  ===================
      ============================================================  -}

transProgram :: Program -> TR Instr
transProgram p@(Program topDefs) = do
  registerAllFunctions p
  registerAllClasses p
  vTablesMock <- createVTables
  strInstrs <- registerAllStrings p
  resInstrs <- mapM transTopDef topDefs
  --error $ "po trans topdefs"
  vTablesInstrs' <- createVTables
  return $ InstrBlock [strInstrs, vTablesInstrs', InstrBlock resInstrs]

transTopDef :: TopDef -> TR Instr
transTopDef (TopFnDef (FnDef t ident args block@(Block stmts))) = do
  funLabel <- getFunLabel ident
  size <- registerFunArgs args
  (venv, fenv, cenv, senv, minSize, maxTmp, labelNo) <- get
  when (M.member (Ident "self") venv) (do
       let (VarType selfT selfAlign) = venv M.! Ident "self"
       when (selfAlign < 0) (
               put (M.insert (Ident "self") (VarType selfT (size + getTypeSize selfT)) venv, fenv, cenv, senv, minSize,
                    maxTmp, labelNo)))
  blockInstrs <- transFunBlock block
  (_, _, _, _, _, _, nextLabelNo) <- get
  put (venv, fenv, cenv, senv, minSize, maxTmp, nextLabelNo)
  let common = InstrBlock [funLabel, prologFunction, blockInstrs]
  if not $ null stmts then
    case last stmts of
      VRet -> return common
      (Ret _) -> return common
      _ -> return $ InstrBlock [common, leaveFunction]
  else
    return $ InstrBlock [common, leaveFunction]

transTopDef (ClassExtDef ident _ clsStmts) = transTopDef (ClassDef ident clsStmts)

transTopDef (ClassDef ident@(Ident clsName) clsStmts) = do
  (venv, fenv, cenv, senv, minSize, maxTmp, labelNo) <- get
  put (M.insert self (newVar (ClsType ident) (-1)) venv, fenv, cenv, senv, minSize, maxTmp, labelNo)
  instrs <- mapM transTopDef [TopFnDef $ classFunDef fndef clsName | (FnProp fndef) <- clsStmts]
  (_, _, _, _, _, _, labelNo) <- get
  put (venv, fenv, cenv, senv, minSize, maxTmp, labelNo)
  return $ InstrBlock instrs

classFunDef (FnDef retType (Ident fname) args block) clsName =
  FnDef retType (Ident $ clsName ++ "$" ++ fname) args block

registerAllFunctions :: Program -> TR ()
registerAllFunctions (Program topdefs) = do
  mapM_ registerFunction [fndef | (TopFnDef fndef) <- topdefs]
  mapM_ registerFunction builtins

registerFunction :: FnDef -> TR ()
registerFunction (FnDef t ident _ _) = do
  (venv, fenv, cenv, senv, minSize, maxTmp, labelNo) <- get
  put (venv, M.insert ident t fenv, cenv, senv, minSize, maxTmp, labelNo)

-- Will also return size of arguments in bytes
registerFunArgs :: [Arg] -> TR Int
registerFunArgs args = registerFunArgsHelper 4 $ reverse args

registerFunArgsHelper :: Int -> [Arg] -> TR Int
registerFunArgsHelper size (Arg t ident:args) = do
  (venv, fenv, cenv, senv, minSize, maxTmp, labelNo) <- get
  let allocSize = getTypeSize t
  let excess = case t of
                  ArrType _ -> 4
                  _ -> 0
  let offset = size + allocSize - excess
  put (M.insert ident (newVar t offset) venv, fenv, cenv, senv, minSize, maxTmp, labelNo)
  registerFunArgsHelper (size + allocSize) args
registerFunArgsHelper size [] = return size

transFunBlock :: Block -> TR Instr
transFunBlock (Block stmts) = do
  oldEnv <- get
  memAlloc <- allocateVariables stmts
  put oldEnv
  blockInstrs <- mapM transStmt stmts
  return $ InstrBlock (memAlloc:blockInstrs)

builtins :: [FnDef]
builtins = [FnDef Void (Ident "printInt") [Arg Int (Ident "n")] (Block [Empty]),
            FnDef Void (Ident "printString") [Arg Str (Ident "str")] (Block [Empty]),
            FnDef Int (Ident "readInt") [] (Block [Empty]),
            FnDef Str (Ident "readString") [] (Block [Empty]),
            FnDef Void (Ident "error") [] (Block [Empty])]

addStrings :: String
addStrings = "addStrings"

getFunLabel :: Ident -> TR Instr
getFunLabel (Ident name) = return $ NoIndent $ name ++ ":"

registerAllClasses :: Program -> TR ()
registerAllClasses (Program topDefs) = do
  let classDefs =
        [(Just parentIdent, ident, clsStmts) | (ClassExtDef ident parentIdent clsStmts) <- topDefs] ++
        [(Nothing, ident, clsStmts) | (ClassDef ident clsStmts) <- topDefs]
  mapM_ registerClass classDefs
  (_, _, cenv, _, _, _, _) <- get
  let clsStmtsEnv = M.fromList [(ident, clsStmts) | (_, ident, clsStmts) <- classDefs]
  let clsIdents = [ident | (_, ident, _) <- classDefs]
  let subClsIdents = [ident | ident <- clsIdents, ident `notElem` [parIdent | ClassType{parent=Just parIdent} <- M.elems cenv]]
  mapM_ (\ident -> initClass (Just ident) S.empty clsStmtsEnv) subClsIdents

registerClass :: (Maybe Ident, Ident, [ClsStmt]) -> TR ()
registerClass (parentIdent, ident, _) = do
  (env, fenv, cenv, senv, minSize, maxTmp, labelNo) <- get
  put (env, fenv, M.insert ident (newClass parentIdent M.empty M.empty (-1) 0) cenv,
    senv, minSize, maxTmp, labelNo)

initClass :: Maybe Ident -> S.Set Ident -> M.Map Ident [ClsStmt] -> TR (VarEnv, Int)
initClass (Just ident) fset clsStmtsEnv = do
  clt <- getClassType ident
  if vmcount clt >= 0 then
    return (venv clt, align clt)
  else do
    let cDefs = case M.lookup ident clsStmtsEnv of
                (Just x) -> x
                Nothing -> error "cdefs M.!"
    let functions = [fndef | (FnProp fndef) <- cDefs]
    let variables = [attrp | attrp@(AttrProp _ _) <- cDefs]
    let newFset = S.union fset $ S.fromList [ident | (FnDef _ ident _ _ ) <- functions]
    (supEnv, supSize) <- initClass (parent clt) newFset clsStmtsEnv
    let (resEnv, resSize) = foldl (\(cenv, csize) (AttrProp t ident) ->
                            (M.insert ident (newVar t csize) cenv, csize + getTypeSize t))
                            (supEnv, supSize) variables
    (supFenv, supMaxVirt) <- case parent clt of
      (Just parIdent) -> do
        parClt <- getClassType parIdent
        return (fenv parClt, vmcount parClt)
      Nothing -> return (M.empty, 0)
    let (resFenv, resMaxVirt) = foldl (\(cFenv, maxVirt) (FnDef t fIdent _ _) ->
                                case M.lookup fIdent cFenv of
                                  Just ClsFunType {vid = Just v} -> (M.insert fIdent (ClsFunType t (Just v) ident) cFenv, maxVirt)
                                  _ -> (M.insert fIdent (ClsFunType t (Just maxVirt) ident) cFenv, maxVirt + 1))
                                  (supFenv, supMaxVirt) functions
    (env, fenv, cenv, senv, minSize, maxTmp, labelNo) <- get
    put (env, fenv, M.insert ident (newClass (parent clt) resEnv resFenv resMaxVirt resSize) cenv, senv, minSize, maxTmp, labelNo)
    return (resEnv, resSize)
initClass Nothing _ _ = return (M.empty, 4)

translate :: Program -> String
translate program = entry ++ show (evalState (transProgram program) initState)
