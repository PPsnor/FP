module Main where

import Controller
import Model
import View

import Graphics.Gloss.Interface.IO.Game

main :: IO ()
main = do 
    level1 <- readFile "level1.txt"
    let bord1 = readLevel (Pt 1 1) level1 emtpy
    playIO (InWindow "Counter" (400, 200) (0, 0)) -- Or FullScreen
              black            -- Background color
              10               -- Frames per second
              initialState bord1     -- Initial state
              view             -- View function
              input            -- Event function
              step             -- Step function