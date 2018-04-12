module Physics.Position exposing (..)

import Tuple exposing (first, second)
import Physics.Distance exposing (Distance)
import Random exposing (Generator)


type alias Position =
    ( Float, Float )


x : Position -> Float
x =
    first


y : Position -> Float
y =
    second


distance : Position -> Position -> Distance
distance ( xA, yA ) ( xB, yB ) =
    let
        x =
            xA - xB

        y =
            yA - yB
    in
        sqrt (x ^ 2 + y ^ 2)


add : Position -> Position -> Position
add ( xA, yA ) ( xB, yB ) =
    ( (xA + xB), (yA + yB) )


generator : Position -> Position -> Generator Position
generator ( minX, minY ) ( maxX, maxY ) =
    Random.pair (Random.float minX maxX) (Random.float minY maxY)
