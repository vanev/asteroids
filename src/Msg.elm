module Msg exposing (..)

import Time exposing (Time)
import Keyboard.Extra
import Asteroid exposing (Asteroid)


type Msg
    = NoOp
    | Tick Time
    | KeyMsg Keyboard.Extra.Msg
    | NewAsteroid Asteroid
