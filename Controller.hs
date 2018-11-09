-- | This module defines how the state changes
--   in response to time and user input
module Controller where

import Model
import Physics

import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game
import System.Random

{-# language NamedFieldPuns #-}

step :: Float -> GameState -> IO GameState --step is voor automatische dingen
step secs gstate@(GameState {vijand = vijand, atze = atze})
 | elapsedTime gstate + secs > nO_SECS_BETWEEN_CYCLES
 = return gstate {atze = updateATze, vijand = updateVijand vijand atze}  
  --Doe alle automatische dingen die moeten gebeuren
     --updateVijand voor alle vijanden in gstate
 | otherwise
 =   --Anders update gewoon de elapsed time
   return $ gstate {elapsedTime = elapsedTime gstate + secs}
   
updateVijand :: Vijand -> Atze -> Vijand
updateVijand vijand atze = case mode vijand of
   Passive -> vijand
   Agressive -> movetowardsAtze vijand atze
   
updateVijandMode :: Vijand -> Atze -> Vijand
updateVijandMode v@(Vijand {vloca = vloca}) a@(Atze {aloca = aloca}) 
   |distance lv la < attackRadius = return v {mode = Agressive}
   |otherwise = return v
   
moveTowardsAtze :: Vijand -> Atze -> Vijand
moveTowardsAtze vijand@(Vijand {vloca = (vx,vy)}) atze@(Atze {aloca = (ax,_)}) 
  | vx < ax = vijand {vloca = (vx + 1, vy)}
  | vx > ax = vijand {vloca = (vx -1 , vy)}
  | otherwise = vijand {vloca = (vx, vy)}

updateAtze :: Atze -> Atze