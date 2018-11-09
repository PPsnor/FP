module Physics where

import Graphics.Gloss

--Euclidian Distance
distance :: Point -> Point -> Float
distance (x1, y1) (x2, y2) = sqrt   $   (dx*dx)   +   (dy*dy) 
 where dx = x1 - x2
       dy = y1 - y2

--Manhattan Distance
mdistance :: Point -> Point -> Float
mdistance (x1,y1) (x2,y2) = abs (x1 - x2) + abs (y1 - y2)