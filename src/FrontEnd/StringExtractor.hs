{-
  "Compiler Construction" course @ MIMUW.
  `Latte` language static code analyzer.

  Author: Michał Preibisch   < mp347207@students.mimuw.edu.pl >
  Lecturer: mgr Artur Zaroda

  StaticChecker implementation.

  This module is responsible for extraction of all string occurrances in program.
-}
module StringExtractor
    (getAllStrings) where

import Data.List as L
import LatteTypes
import ErrM

getAllStrings = extractStrings

extractStrings :: Program -> [String]
extractStrings (Program topDefs) = nub $ extractStringsTopDefs topDefs

extractStringsTopDefs :: [TopDef] -> [String]
extractStringsTopDefs = concatMap extractStringsTopDef

extractStringsTopDef :: TopDef -> [String]
extractStringsTopDef (TopFnDef (FnDef _ _ _ (Block stmts))) = extractStringsStmts stmts

extractStringsTopDef (ClassDef _ clsStmts) = extractStringsClsStmts clsStmts

extractStringsTopDef (ClassExtDef _ _ clsStmts) = extractStringsClsStmts clsStmts

extractStringsClsStmts :: [ClsStmt] -> [String]
extractStringsClsStmts = concatMap extractStringsClsStmt

extractStringsClsStmt :: ClsStmt -> [String]
extractStringsClsStmt (FnProp fnDef) = extractStringsTopDef (TopFnDef fnDef)

extractStringsClsStmt _ = []

extractStringsStmts :: [Stmt] -> [String]
extractStringsStmts = concatMap extractStringsStmt

extractStringsStmt :: Stmt -> [String]
extractStringsStmt (BStmt (Block stmts)) = extractStringsStmts stmts

extractStringsStmt (Decl Str items) = concatMap extractStringsItem items

extractStringsStmt (Ass _ expr) = extractStringsExpr expr

extractStringsStmt (Ret expr) = extractStringsExpr expr

extractStringsStmt (Cond expr stmt) = extractStringsExpr expr ++ extractStringsStmt stmt

extractStringsStmt (CondElse expr stmt1 stmt2) = extractStringsExpr expr ++ extractStringsStmt stmt1 ++
        extractStringsStmt stmt2

extractStringsStmt (While expr stmt) = extractStringsStmt (Cond expr stmt)

extractStringsStmt (For _ _ expr stmt) = extractStringsExpr expr ++ extractStringsStmt stmt

extractStringsStmt (SExp expr) = extractStringsExpr expr

extractStringsStmt _ = []

extractStringsItem :: Item -> [String]
extractStringsItem (Init _ expr) = extractStringsExpr expr

extractStringsItem (NoInit _) = [""]

extractStringsExpr :: Expr -> [String]
extractStringsExpr (EString str) = [str]

extractStringsExpr (EApp _ exprs) = concatMap extractStringsExpr exprs

extractStringsExpr (EAdd expr1 Plus expr2) = extractStringsExpr expr1 ++ extractStringsExpr expr2

extractStringsExpr _ = []
