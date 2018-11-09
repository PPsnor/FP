-- | This module defines how to turn
--   the game state into a picture
module View where

import Graphics.Gloss
import Model
import Data.Map

view :: GameState -> IO Picture
view = return . viewPure

viewPure :: GameState -> Picture
viewPure (GameState bord atze _ _) = pictures ((tekenAtze atze) : ([ tekenBord x | x <- (Data.Map.toList bord)]))

tekenBord :: (Point2,Veld) -> Picture
tekenBord ((Pt x y), veld) = case veld of
  Lucht -> pictures [translate (20 * x) (20 * y) (color blue (rectangleSolid 20 80))] -- Dit achtergrond maken
  Grond -> pictures [translate (20 * x) (20 * y) (color green (rectangleSOlid 20 20))]

tekenAtze :: Atze -> Picture
tekenAtze (Atze (Pt x y) _) = pictures [translate (20*x) (80*y) (color red (circle 20))]
  
  
  --case infoToShow gstate of
  --ShowNothing   -> blank
  --ShowANumber n -> color green (text (show n))
  --ShowAChar   c -> color green (text [c])