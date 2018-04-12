module Physics.Direction exposing (..)

import Random exposing (Generator)


type alias Direction =
    Float


generator : Generator Direction
generator =
    Random.float (degrees 0) (degrees 360)
