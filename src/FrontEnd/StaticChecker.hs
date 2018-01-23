{-
  "Compiler Construction" course @ MIMUW.
  `Latte` language static code analyzer.

  Author: Michał Preibisch   < mp347207@students.mimuw.edu.pl >
  Lecturer: mgr Artur Zaroda

  StaticChecker implementation.

  This module is responsible for code static analyzis. It will detect any
  errors that can be detected during compilation, such as:
  - Using undeclared variables or functions
  - Absence of "return" statement in non-void functions
  - Incorrect types (e.g.  int x = "word")
-}

module StaticChecker where

import LatteTypes
import ErrM
import ParLatte
import System.Environment
import System.IO
import Control.Monad.State
import Control.Monad.Trans.Except
import Data.Maybe
import qualified Data.Map as M
import qualified Data.List as L

type TT a = ExceptT CheckerError (State Env) a

type RetType = Type

-- Depth of declarations.
type Depth = Integer

-- Variables environment.
type VarEnv = M.Map Ident VarType

-- Functions environment.
type FunEnv = M.Map Ident FunType

-- Class (objects) environment.
type ClassEnv = M.Map Ident ClassType

-- Data type for functions
data FunType = FunType {
  fvEnv :: VarEnv,
  fret :: RetType,
  fargs :: [Arg],
  fblock :: Block
}

-- Data type for classes
data ClassType = ClassType {
  csname :: Maybe Ident, -- csname == "Class Super Name" ; ident of a superclass
  cvEnv :: VarEnv,
  cfEnv :: FunEnv
}

-- Data type for variables. Depth stands for level of block in which variable was declared.
data VarType = VarType {
  vtype :: Type,
  vdepth :: Depth
} deriving Show

-- Environment
type Env = (VarEnv, FunEnv, ClassEnv, Depth)

initEnv :: Env
initEnv = (M.empty, M.empty, M.empty, 0)

newClass :: Maybe Ident -> ClassType
newClass ident = ClassType {
  csname = ident,
  cvEnv = M.empty,
  cfEnv = M.empty
}

createClass :: Maybe Ident -> VarEnv -> FunEnv -> ClassType
createClass ident venv fenv = ClassType {
  csname = ident,
  cvEnv = venv,
  cfEnv = fenv
}

newVar :: Type -> Depth -> VarType
newVar t depth = VarType {
  vtype = t,
  vdepth = depth
}

newFun :: VarEnv -> RetType -> [Arg] -> Block -> FunType
newFun env t args block = FunType {
  fvEnv = env,
  fret = t,
  fargs = args,
  fblock = block
}
-- Datatype for error displaying.
data CheckerError =
    OtherErr String | UndeclaredFun Ident | UndeclaredVar Ident |
    WrongRetType Type Type | TypesMismatch Type Type | NoRet Ident |
    WrongArgType Ident Type Type | WrongArgCount Int Int | WrongIndexType Type |
    Redeclaration Ident | UnknownClass Ident | UnknownClsAttr Ident |
    NonObjectType Type | NonArrayType Type | NonIntArithmetic | IllegalLogicalOp |
    UnreachableCode [Stmt] | ClassRedeclaration Ident | UnknownArrayAttr Ident |
    RepeatedArgName Ident

-- Error messages.
instance Show CheckerError where
  show (OtherErr message) = message
  show (UndeclaredFun name) = "Undeclared function: " ++ show name
  show (UndeclaredVar name) = "Undeclared variable: " ++ show name
  show (WrongRetType found expected) =
     "Wrong return type. Expected: " ++ show expected ++ ". Found: " ++ show found
  show (TypesMismatch found expected) =
    "Incorrect types. Expected: " ++ show expected ++ ". Found: " ++ show found
  show (NoRet name) = "No return statement in non-void function " ++ show name
  show (WrongArgType name found expected) =
     "Wrong type of arguments in function. Arg name: " ++ show name ++ "Expected: " ++ show expected ++ ". Found: " ++ show found
  show (WrongArgCount found expected) =
    "Wrong number of arguments. Expected " ++ show expected ++ " args, found " ++ show found
  show (WrongIndexType found) = "Wrong array index type. Expected int, found " ++ show found
  show (Redeclaration ident) = "Redeclaration of " ++ show ident ++ " within the same block."
  show (UnknownClass name) = "Unknown class: " ++ show name
  show (UnknownClsAttr name) = "Unknown class attribute: " ++ show name
  show (NonObjectType found) = "Expected object type, found: " ++ show found
  show (NonArrayType found) = "Expected array type, found: " ++  show found
  show NonIntArithmetic = "Numerical operation on non-integers."
  show IllegalLogicalOp = "Logical operation on non-boolean types."
  show (UnreachableCode stmts) = "Unreachable code! Unreachable statements: " ++ show stmts
  show (ClassRedeclaration ident) = "Redeclaration of a class: " ++ show ident
  show (UnknownArrayAttr ident) = "Unknown array attribute: " ++ show ident
  show (RepeatedArgName ident) = "Repeated argument name:" ++ show ident

{-    ============================================================
      ===============     BUILT-IN FUNCTIONS      ================
      ============================================================  -}


builtins = [(Void, Ident "printInt", [Arg Int (Ident "n")], Block[Empty]),
            (Void, Ident "printString", [Arg Str (Ident "str")], Block[Empty]),
            (Int, Ident "readInt", [], Block[Empty]),
            (Str, Ident "readString", [], Block[Empty]),
            (Void, Ident "error", [], Block[Empty])]

{-    ============================================================
      ===============      EXPRESSIONS CHECK      ================
      ============================================================  -}

checkExpr :: Expr -> TT Type
checkExpr (ELitInt _) = return Int

checkExpr (EString _) = return Str

checkExpr ELitTrue = return Bool

checkExpr ELitFalse = return Bool

checkExpr (EMul e1 _ e2) = do
    t1 <- checkExpr e1
    t2 <- checkExpr e2
    if t1 == Int && t2 == Int then return Int
    else throwE NonIntArithmetic

checkExpr (EAdd e1 _ e2) = do
    t1 <- checkExpr e1
    t2 <- checkExpr e2
    if t1 == Int && t2 == Int then return Int
    else
      if t1 == Str && t2 == Str then
        return Str
      else
        throwE $ TypesMismatch t1 t2

checkExpr (EVar ident) = do
  (venv, _, _, _) <- get
  case M.lookup ident venv of
    Just e -> return (vtype e)
    Nothing -> throwE $ UndeclaredVar ident

checkExpr (Neg expr) = do
  t1 <- checkExpr expr
  if t1 /= Int then
    throwE $ TypesMismatch t1 Int
  else
    return Int

checkExpr (Not expr) = do
  t1 <- checkExpr expr
  if t1 /= Bool then
    throwE $ TypesMismatch t1 Bool
  else
    return Bool

checkExpr (ERel e1 op e2) = do
  t1 <- checkExpr e1
  t2 <- checkExpr e2
  let x = print t1
  if op == EQU || op == NE then
    if t1 == t2 then
      return Bool
    else
      throwE $ TypesMismatch t1 t2
  else
    if isNumeric t1 && isNumeric t2 then
      return Bool
    else
      throwE $ TypesMismatch t1 t2

checkExpr (EAnd e1 e2) = checkLogicalOp e1 e2

checkExpr (EOr e1 e2) = checkLogicalOp e1 e2

checkExpr (ENullCast ident) = do
  (_, _, clsEnv, _) <- get
  case M.lookup ident clsEnv of
    Just e -> return (ClsType ident)
    Nothing -> throwE $ NonObjectType Int -- todo

checkExpr (EArrGet expr idx) = do
  i <- checkExpr idx
  at <- checkExpr expr
  if isNumeric i then
    case at of
      (ArrType t) -> return t
      x -> throwE $ NonArrayType at
  else
    throwE $ WrongIndexType i

checkExpr (ENewArr atype expr) = do
  i <- checkExpr expr
  if isNumeric i then
    return (ArrType atype)
  else
    throwE $ WrongIndexType i

checkExpr (ENewCls (ClsType ident)) = do
  (_, _, clsEnv, _) <- get
  case M.lookup ident clsEnv of
    Just e -> return (ClsType ident)
    Nothing -> throwE $ UnknownClass ident

checkExpr (EApp ident exprs) = do
  funType <- getFunType ident
  argTypes <- mapM checkExpr exprs
  (venv, fenv, cenv, depth) <- get
  put (fvEnv funType, fenv, cenv, depth)
  checkFunArgs (fargs funType) argTypes
  put (venv, fenv, cenv, depth)
  return (fret funType)

checkExpr (EProp expr ident) = do
  clt <- checkExpr expr
  case clt of
    (ArrType _) -> if ident == Ident "length" then
      return Int
    else
      throwE $ UnknownArrayAttr ident
    (ClsType name) -> do
      (_, _, cenv, _) <- get
      case M.lookup name cenv of
        Just e -> case M.lookup ident (cvEnv e) of
          Just x -> return (vtype x)
          Nothing -> throwE $ UnknownClsAttr ident
        Nothing -> throwE $ UnknownClass name
    t -> throwE $ NonObjectType t

checkExpr (EPropApp expr ident exprs) = do
  clt <- checkExpr expr
  case clt of
    (ClsType name) -> do
      (cvenv, cfenv) <- getClassEnv name
      (venv, fenv, cenv, depth) <- get
      put (M.union cvenv venv, M.union cfenv fenv, cenv, depth)
      res <- checkExpr (EApp ident exprs)
      put (venv, fenv, cenv, depth)
      return res
    _ -> throwE $ NonObjectType clt


checkFunArgs :: [Arg] -> [Type] -> TT ()
checkFunArgs args argTypes = do
  let (c1, c2) = (length argTypes, length args)
  if c1 /= c2 then
    throwE $ WrongArgCount c1 c2
  else
    zipWithM_ checkSingleArg args argTypes

checkSingleArg :: Arg -> Type -> TT ()
checkSingleArg (Arg argt ident) t = do
  noErr <- typesMatch argt t
  depth <- getDepth
  if noErr then
    void $ declareVar argt ident depth
  else
    throwE $ WrongArgType ident t argt

isNumeric Int = True
isNumeric _ = False

checkForRepeatedArgs :: [Arg] -> TT ()
checkForRepeatedArgs args =
  let argNames = [name | (Arg t name) <- args] in
  let repeated = duplicatedElems argNames in
  unless (null repeated) (throwE $ RepeatedArgName $ head repeated)


duplicatedElems [] = []
duplicatedElems (x:xs) = case [y | y <- xs, y == x] of
                    (y:ys) -> [y]
                    [] -> duplicatedElems xs

getArgsTypes :: [Arg] -> [Type]
getArgsTypes args = [t | (Arg t _) <- args]

checkLogicalOp :: Expr -> Expr -> TT Type
checkLogicalOp e1 e2 = do
    t1 <- checkExpr e1
    t2 <- checkExpr e2
    if t1 /= Bool || t2 /= Bool then
      throwE IllegalLogicalOp
    else
      return Bool

{-    ============================================================
      ===============    TOP DEFINITIONS CHECK    ================
      ============================================================  -}

checkTopDef :: TopDef -> TT ()
checkTopDef (TopFnDef (FnDef ret ident args block)) =
  catchE (checkFunctionDef (FnDef ret ident args block)) (\exc ->
    throwE $ OtherErr $ "In function '" ++ show ident ++ "': " ++ show exc)

checkTopDef (ClassDef ident stmts) = checkClassDefMeta ident Nothing stmts

checkTopDef (ClassExtDef ident supident stmts) = checkClassDefMeta ident (Just supident) stmts

checkClassDefMeta :: Ident -> Maybe Ident -> [ClsStmt] -> TT ()
checkClassDefMeta ident parentIdent cdefs = catchE (checkClassDef ident parentIdent cdefs) (\exc ->
    throwE $ OtherErr $ "In class definition for '" ++ show ident ++ "': " ++ show exc)


checkProgram :: Program -> TT ()
checkProgram (Program topdefs) = do
  let funs = [fndef | (TopFnDef fndef) <- topdefs]
  let classes = filter (\def -> case def of
        (TopFnDef _) -> False
        _ -> True) topdefs
  mapM_ (\(ret, ident, args, block) -> registerFunction ret ident args block) builtins
  mapM_ (\(FnDef ret ident args block) -> registerFunction ret ident args block) funs
  mapM_ (\cldef -> case cldef of
    (ClassDef ident cstmts) -> registerClass ident Nothing cstmts
    (ClassExtDef ident supident cstmts) -> registerClass ident (Just supident) cstmts) classes
  mapM_ checkTopDef topdefs


checkClassDef :: Ident -> Maybe Ident -> [ClsStmt] -> TT ()
checkClassDef ident supident cstmts = do
  when (isJust supident) (void $ getClassEnv (fromJust supident)) -- getClassEnv checks for validity of inheritance
  (cvenv, cfenv) <- getClassEnv ident
  let funs = [f | (FnProp f) <- cstmts]
  mapM_ (\fun -> do
    (venv, fenv, cenv, depth) <- get
    put (cvenv, fenv, cenv, depth)
    newDepth <- incDepth
    declareVar (ClsType ident) (Ident "self") newDepth -- for the purpose of "self.attr"
    checkFunctionDef fun
    put (venv, fenv, cenv, depth)) funs

checkFunctionDef :: FnDef -> TT ()
checkFunctionDef (FnDef ret ident args (Block block)) = do
  oldEnv <- get
  checkForRepeatedArgs args
  registerArgs args
  retType <- checkBlock block
  put oldEnv
  if isNothing retType && ret /= Void then
    throwE $ NoRet ident
  else
    unless (isNothing retType) $ do
      noErr <- typesMatch (fromJust retType) ret
      unless noErr $ throwE $ WrongRetType (fromJust retType) ret

registerFunction :: Type -> Ident -> [Arg] -> Block -> TT ()
registerFunction t ident args block = do
  (venv, fenv, cenv, depth) <- get
  put (venv, M.insert ident (newFun venv t args block) fenv, cenv, depth)

registerClass :: Ident -> Maybe Ident -> [ClsStmt] -> TT ()
registerClass ident supident stmts = do
  (venv, fenv, cenv, depth) <- get
  let cVenv = M.fromList [(i, newVar t depth) | (AttrProp t i) <- stmts]
  let cFenv = M.fromList [(ident, newFun venv t args block) | (FnProp (FnDef t ident args block)) <- stmts]
  put (venv, fenv, M.insert ident (createClass supident cVenv cFenv) cenv, depth)

registerArgs :: [Arg] -> TT ()
registerArgs = mapM_ registerArg

registerArg :: Arg -> TT ()
registerArg (Arg t ident) = do
  depth <- getDepth
  void $ declareVar t ident depth

-- INHERITANCE: Compute an union of all envs up to the last ancestor.
-- Because Map.union is "left-biased", 'lower level' env shall be left argument of union
getClassEnv :: Ident -> TT (VarEnv, FunEnv)
getClassEnv ident = do
  clt <- getClassType ident
  case csname clt of
    (Just parent) -> do
      (parentVenv, parentFenv) <- getClassEnv parent
      return (M.union (cvEnv clt) parentVenv, M.union (cfEnv clt) parentFenv)
    Nothing -> return (cvEnv clt, cfEnv clt)

{-    ============================================================
      ===============    STATEMENTS CHECK    ================
      ============================================================  -}

checkStmt :: Stmt -> TT (Maybe Type)
checkStmt (BStmt (Block stmts)) = do
  oldEnv <- get
  incDepth
  res <- checkBlock stmts
  put oldEnv
  return res

checkStmt (Decl t items) = do
  mapM_ (checkSingleDecl t) items
  return Nothing

checkStmt (Ass e1 e2) = do
  t2 <- checkExpr e1
  t1 <- checkExpr e2
  noErr <- typesMatch t1 t2
  if noErr then
    return Nothing
  else
    throwE $ TypesMismatch t1 t2

checkStmt (Ret expr) = do
  t <- checkExpr expr
  return (Just t)

checkStmt VRet = return (Just Void)

checkStmt (Cond expr stmt) = checkStmt (CondElse expr stmt Empty)

checkStmt (CondElse expr stmt1 stmt2) = do
  checkIfBoolExpr expr
  case expr of
    ELitTrue ->  checkStmt stmt1
    ELitFalse -> checkStmt stmt2
    _ -> do
      t1 <- checkStmtLocal stmt1
      t2 <- checkStmtLocal stmt2
      if isNothing t1 || isNothing t2 then
        return Nothing
      else
        if t1 /= t2 then
          throwE $ TypesMismatch (fromJust t1) (fromJust t2)
        else
          return t1

checkStmt (While expr stmt) = do
  checkIfBoolExpr expr
  checkStmt stmt

checkStmt (SExp expr) = do
  checkExpr expr
  return Nothing

checkStmt (For t ident expr stmt) = do
  ct <- checkExpr expr      -- container type
  case ct of
    (ArrType t) -> do
      (venv, fenv, cenv, depth) <- get
      case M.lookup ident venv of
        Nothing -> checkLocal t ident stmt
        Just e -> if vdepth e == depth then
            throwE $ Redeclaration ident
          else checkLocal t ident stmt
    _ -> throwE $ TypesMismatch (ArrType t) ct

checkStmt (Incr expr) = checkIncDecStmt expr
checkStmt (Decr expr) = checkIncDecStmt expr
checkStmt _ = return Nothing

checkStmtLocal :: Stmt -> TT (Maybe Type)
checkStmtLocal stmt = do
  oldEnv <- get
  res <- checkStmt stmt
  put oldEnv
  return res

checkBlock :: [Stmt] -> TT (Maybe Type)
checkBlock (h:t) = do
  r <- checkStmt h
  case r of
    (Just x) -> if null t then return r else throwE $ UnreachableCode t
    Nothing -> checkBlock t
checkBlock [] = return Nothing

checkLocal t ident stmt = do
  (venv, fenv, cenv, depth) <- get
  declareVar t ident depth
  res <- checkStmt stmt
  put (venv, fenv, cenv, depth)
  return res

checkIfBoolExpr :: Expr -> TT ()
checkIfBoolExpr expr = do
  t <- checkExpr expr
  when (t /= Bool) $ throwE $ TypesMismatch Bool t

declareVar :: Type -> Ident -> Depth -> TT (Maybe Type)
declareVar t ident depth = do
  (venv, fenv, cenv, depth) <- get
  put (M.insert ident (newVar t depth) venv, fenv, cenv, depth)
  return Nothing

incDepth :: TT Depth
incDepth = do
  (venv, fenv, cenv, depth) <- get
  put (venv, fenv, cenv, depth + 1)
  return (depth + 1)

getDepth :: TT Depth
getDepth = do
  (_, _, _, depth) <- get
  return depth

checkSingleDecl :: Type -> Item -> TT (Maybe Type)
checkSingleDecl t (NoInit ident) = checkSingleDeclHelper t ident
checkSingleDecl t (Init ident expr) = do
      et <- checkExpr expr
      noErr <- typesMatch et t
      if noErr then
        checkSingleDeclHelper t ident
      else
        throwE $ TypesMismatch et t

checkSingleDeclHelper :: Type -> Ident -> TT (Maybe Type)
checkSingleDeclHelper t ident = do
    (venv, fenv, cenv, depth) <- get
    case M.lookup ident venv of
      Just e -> if vdepth e == depth then
          throwE $ Redeclaration ident
        else
          declareVar t ident depth
      Nothing -> declareVar t ident depth
    return Nothing

checkIncDecStmt expr = do
  t <- checkExpr expr
  if t /= Int then
    throwE $ TypesMismatch Int t
  else
    return Nothing

typesMatch :: Type -> Type -> TT Bool
typesMatch t1 t2
  | t1 == t2 = return True
  | otherwise = case (t1, t2) of
    (ClsType sub, ClsType sup) -> isSubclass sub sup
    _ -> return False

isSubclass :: Ident -> Ident -> TT Bool
isSubclass sub sup = do
  cls <- getClassType sub
  case csname cls of
    (Just parent) -> if sup == parent then return True else isSubclass parent sup
    Nothing -> return False

getClassType :: Ident -> TT ClassType
getClassType ident = do
  (_, _, cenv, _) <- get
  case M.lookup ident cenv of
      (Just cls) -> return cls
      Nothing -> throwE $ UnknownClass ident

getFunType :: Ident -> TT FunType
getFunType ident = do
  (_, fenv, _, _) <- get
  case M.lookup ident fenv of
      (Just fun) -> return fun
      Nothing -> throwE $ UndeclaredFun ident

typeCheck :: Program -> Maybe String
typeCheck program = case evalState (runExceptT (checkProgram program)) initEnv of
    (Right _) -> Nothing
    (Left exc) -> case exc of
        (OtherErr msg) -> Just msg
        err -> Just $ "Error: " ++ show err


parser = pProgram . myLexer


main :: IO ()
main = do
   file <- getArgs
   case file of
       [] -> error "No args provided!"
       file:_ -> do
           program <- readFile file
           case parser program of
               Ok p  -> case typeCheck p of
                 Nothing -> putStrLn "OK"
                 Just s -> putStrLn $ "ERROR\n" ++ s
               Bad e -> putStrLn $ "ERROR\n" ++ e
