module Print3Broken where

printSecond :: IO ()

greeting = "Yarrrr"

printSecond = do
    putStrLn greeting

main :: IO ()
main = do
    putStrLn greeting
    printSecond


