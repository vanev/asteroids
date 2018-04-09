module Physics.Velocity exposing (..)

import Tuple exposing (first, second)
import Time exposing (Time)
import Physics.Speed exposing (Speed)
import Physics.Direction exposing (Direction)
import Physics.Position exposing (Position)


type alias Velocity =
    ( Speed, Direction )


speed : Velocity -> Speed
speed =
    first


direction : Velocity -> Direction
direction =
    second


position : Time -> Velocity -> Position
position time ( speed, direction ) =
    let
        distance =
            speed * time

        y =
            (sin direction) * distance

        x =
            (cos direction) * distance
    in
        ( x, y )


add : Velocity -> Velocity -> Velocity
add a b =
    let
        ( xA, yA ) =
            fromPolar a

        ( xB, yB ) =
            fromPolar b
    in
        toPolar ( (xA + xB), (yA + yB) )
