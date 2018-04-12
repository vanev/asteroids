module Physics.Speed exposing (..)

import Physics.Distance exposing (Distance)
import Time exposing (Time)
import Random exposing (Generator)


type alias Speed =
    Float


time : Distance -> Speed -> Time
time =
    (/)


distance : Time -> Speed -> Distance
distance =
    (*)


generator : Speed -> Speed -> Generator Speed
generator =
    Random.float
