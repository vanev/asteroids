module Msg exposing (..)

import Time exposing (Time)
import Keyboard.Extra


type Msg
    = NoOp
    | Tick Time
    | KeyMsg Keyboard.Extra.Msg
