import Data.List

main = do
    x <- getContents
    putStrLn (show (run (lines x)))


run :: [String] -> Int 
run [] = 0 
run (x:xs) = ((quot (read x) 3) - 2) + (run xs)