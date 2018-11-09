-- | This module contains the data types
--   which represent the state of the game


module Model where
import Data.Map
import Graphics.Gloss

{-# language NamedFieldPuns #-}

nO_SECS_BETWEEN_CYCLES :: Float
nO_SECS_BETWEEN_CYCLES = 1

attackRadius :: Int
attackRadius = 5





data GameState = GameState 
 {
  bord :: Bord,
  atze :: Atze,
  elapsedTime :: Float,
  infoToShow :: InfoToShow,
  vijand :: Vijand
 }

data Atze = Atze 
 {
  aloca :: Point,
  astatus :: Status
 }

data Vijand = Vijand 
 {
  vloca :: Point,
  vstatus :: Status,
  mode :: EnemyMode
 }

data InfoToShow = ShowNothing
                | ShowANumber Int
                | ShowAChar   Char




type Bord = Map Point Veld
data Veld = Lucht | Grond
data Status = Dood | Levend
data EnemyMode = Passive | Agressive
          
                



initialState :: Bord -> GameState
initialState b = GameState {bord = b, atze = initializeAtze, elapsedTime = 0, vijand = initializeVijand, infoToShow = ShowNothing}

initializeAtze :: Atze
initializeAtze = Atze {aloca = (5, 5), astatus = Levend}

initializeVijand :: Vijand
initializeVijand = Vijand {vloca = (1,9), vstatus = Levend, mode = Passive}

readLevel :: Point -> [Char] -> Bord -> Bord
readLevel (x,y) ('0' : xs) bord = readLevel ((x+1), y) xs (insert (x, y) Lucht bord)
readLevel (x,y) ('x' : xs) bord = readLevel ((x+1), y) xs (insert (x, y) Grond bord)
readLevel (x,y) ('\n': xs) bord = readLevel (1, (y+1)) xs bord
readLevel _ [] bord = bord