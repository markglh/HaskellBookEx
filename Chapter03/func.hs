module Func1 where
getChar4 :: String -> String
getChar4 x = take 4 x

main :: IO ()
main = print (getChar4("Curry is Awesome"))
--could also write:
--main = print $ getChar4("Curry is Awesome")
