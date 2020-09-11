module Utils where

import System.Random
import Control.Monad.Random
import Control.Lens
import Data.Bool

-- Enum Cycling. Useful to cycle data Key which derives Enum
next :: (Eq a, Enum a, Bounded a) => a -> a
next = bool minBound <$> succ <*> (/= maxBound)

prev :: (Eq a, Enum a, Bounded a) => a -> a
prev = bool maxBound <$> pred <*> (/= minBound)

--helper functon to avoid exceeding maximum beats in bar
listSumCeiling :: (Ord a, Num a) => [a] -> a -> [a]
listSumCeiling list n = takeWhile (< n) $ scanl1 (+) list

pickNRandom:: MonadRandom m => [a] -> Int -> m [a]
pickNRandom line n = do
    list <- createRandomList (length line - 1) n  
    return $ [line !! x | x <- list]

-- creates Random list such that sum is under certain number
pickNSumCeiling:: MonadRandom m => [a] -> Int -> m [a]
pickNSumCeiling line n = do
    list <- createRandomList (length line - 1) n 
    return $ [line !! x | x <- listSumCeiling (list) 4]

createRandomList :: (MonadRandom m, Random a, Num a) => a -> Int -> m [a]
createRandomList x n = do
    ret <- getRandomRs (0, x)
    return $ take n ret

createRandom :: (MonadRandom m, Random a, Num a) => a -> a -> m a
createRandom x n = do
    ret <- getRandomR (n, x)
    return ret

-- useful for 12 tone music
shuffle :: MonadRandom m => [a] -> m [a]
shuffle x = if length x < 2 then return x else do
    i <- createRandom 0  $ length(x)-1 
    r <- shuffle (take i x ++ drop (i+1) x)
    return (x!! i : r)

--function to replace element in list
replace :: Traversable t => t a -> (Int, a) -> t a
replace line (i,n) = (element i .~ n ) line

