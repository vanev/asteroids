module Physics.Speed exposing (..)

import Physics.Distance exposing (Distance)
import Time exposing (Time)


type alias Speed =
    Float


time : Distance -> Speed -> Time
time =
    (/)


distance : Time -> Speed -> Distance
distance =
    (*)
