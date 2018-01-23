{-
  "Compiler Construction" course @ MIMUW.
  `Latte` language static code analyzer.

  Author: Michał Preibisch   < mp347207@students.mimuw.edu.pl >
  Lecturer: mgr Artur Zaroda

  Module with types (mostly tokens from language) used in compilers Front-end.
-}

module LatteTypes where


newtype Ident = Ident String deriving (Eq, Ord, Read)
newtype Program = Program [TopDef]
  deriving (Eq, Ord, Show, Read)

instance Show Ident where
  show (Ident x) = show x

data TopDef
    = TopFnDef FnDef
    | ClassExtDef Ident Ident [ClsStmt]
    | ClassDef Ident [ClsStmt]
  deriving (Eq, Ord, Show, Read)

data ClsStmt = FnProp FnDef | AttrProp Type Ident
  deriving (Eq, Ord, Show, Read)

data Arg = Arg Type Ident
  deriving (Eq, Ord, Show, Read)

data FnDef = FnDef Type Ident [Arg] Block
  deriving (Eq, Ord, Show, Read)

newtype Block = Block [Stmt]
  deriving (Eq, Ord, Show, Read)

data Stmt
    = Empty
    | BStmt Block
    | Decl Type [Item]
    | Ass Expr Expr
    | Incr Expr
    | Decr Expr
    | Ret Expr
    | VRet
    | Cond Expr Stmt
    | CondElse Expr Stmt Stmt
    | While Expr Stmt
    | SExp Expr
    | For Type Ident Expr Stmt
  deriving (Eq, Ord, Show, Read)

data Item = NoInit Ident | Init Ident Expr
  deriving (Eq, Ord, Show, Read)

data Type
    = Int
    | Str
    | Bool
    | Void
    | ArrType Type
    | ClsType Ident
    | Fun Type [Type]
    | Arr Type Integer
    | Pointer Type
    | VTable Ident
  deriving (Eq, Ord, Show, Read)

data Expr
    = EVar Ident
    | ELitInt Integer
    | ELitTrue
    | ELitFalse
    | ENewCls Type
    | ENewArr Type Expr
    | EApp Ident [Expr]
    | EPropApp Expr Ident [Expr]
    | EProp Expr Ident
    | EArrGet Expr Expr
    | ENullCast Ident
    | EString String
    | Neg Expr
    | Not Expr
    | EMul Expr MulOp Expr
    | EAdd Expr AddOp Expr
    | ERel Expr RelOp Expr
    | EAnd Expr Expr
    | EOr Expr Expr
  deriving (Eq, Ord, Show, Read)

data AddOp = Plus | Minus
  deriving (Eq, Ord, Show, Read)

data MulOp = Times | Div | Mod
  deriving (Eq, Ord, Show, Read)

data RelOp = LTH | LE | GTH | GE | EQU | NE
  deriving (Eq, Ord, Show, Read)
