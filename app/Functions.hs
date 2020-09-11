module Functions where

import Structures

--Function that shifts (root) note to another key 
makeKey :: [Semitone] -> Key -> Octave -> [Pulse]
makeKey line k octave = map (\x -> x + key(k) + (octave * 12)) line

createScale2 :: Key -> [Semitone] -> Octave -> Scale Semitone
createScale2 root intervals octave = (Scale (map (\x -> x + key(root) + (octave * 12)) intervals))

--Creates Scale in Key in Octave
createScale :: Key -> [Semitone] -> Octave -> Scale Semitone
createScale root intervals octave = (Scale (makeKey intervals root octave))

makeScale :: Num a => Scale a -> a -> Scale a
makeScale scale i = (Scale (map (\x -> x + i) (intervals scale)))

-- basically subtract the chord we want to go to from the current chord to get an offset.
transposeScale3 :: Scale Semitone -> Semitone -> Key-> Scale Semitone
transposeScale3 scale i k = 
    let offset = i - (key(k))
    in (Scale (map (\x -> x + (i - (key(k)))) (intervals scale)))

transposeScale2 :: Scale Semitone -> Semitone -> Key-> Scale Semitone
transposeScale2 scale i k = Scale (map (\x -> x + (i - (key(k)))) (intervals scale))


--Create some basic scales
majorScale root octave = createScale root majScale octave

minorScale root octave = createScale root minScale octave

majorPentagonic root octave = createScale root majPentagonic octave

minorPentagonic root octave = createScale root minPentagonic octave

diminishedScale root octave = createScale root dimScale octave

augmentedScale root octave = createScale root augScale octave

chordScale root octave = createScale root fifthsMScale octave

fifthsMinorScale root octave = createScale root fifthsmScale octave

--  Fetches Enum value by indice
getKey :: Int -> Key
getKey i = [A ..] !! (i `mod` 12)

-- Fetches indice from Key
key :: Enum a => a -> Semitone
key k = fromIntegral $ fromEnum k 

-- returns key from a chord progression indice
mapProgToKey2 :: Key -> Int -> Octave -> Semitone
mapProgToKey2 k indice octave =
    let scale = majorScale k octave
    in ((intervals scale) !! (indice -1)) -1
