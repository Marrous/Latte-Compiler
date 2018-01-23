module Main where

import Data.List
import Data.List.Split
import System.Environment (getArgs)
import System.IO
import System.Process
import System.Exit

import AbsLatte
import ErrM
import LexLatte
import ParLatte
import PrintLatte
import StaticChecker (typeCheck)
import Translator (translate)

compile :: String -> String -> IO (Maybe String)
compile code inputFile = do
    let tokens = myLexer code
    case pProgram tokens of
        Bad errorStr -> return $ Just ("Parse error in file : " ++ inputFile ++ "\n\n\n" ++ errorStr ++ "\nTokens: " ++ show tokens)
        Ok program -> case typeCheck program of
            Nothing -> do
                let res = translate program
                let pathSplit = splitOn "/" inputFile
                let className = head $ splitOn "." $ last pathSplit
                let path = intercalate "/" $ take (length pathSplit - 1) pathSplit
                let newPath = path ++ (if path == "" then "" else "/") ++ className
                let asmPath = newPath ++ ".s"
                let compileCmd = "g++ -m32 -ggdb lib/runtime.o " ++ asmPath ++ " -o " ++ newPath
                hPutStrLn stderr "OK"
                putStrLn $ "Writing to file named: " ++ asmPath
                writeFile asmPath res
                putStrLn $ "Launching compiler...\n\t" ++ compileCmd
                system compileCmd
                putStrLn "Compilation finished!"
                return Nothing
            err -> return err

main :: IO ()
main = do
    inputFiles <- getArgs
    case inputFiles of
        [inputFile] -> do
            code <- readFile inputFile
            compileRes <- compile code inputFile
            case compileRes of
                Just err -> do
                    hPutStrLn stderr $ "ERROR\n" ++ err
                    exitFailure
                Nothing -> return ()
        _ -> hPutStrLn stderr "ERROR: No args provided!"
