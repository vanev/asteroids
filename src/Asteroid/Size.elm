module Asteroid.Size exposing (Size(..), generator)

import Random exposing (Generator)


type Size
    = Small
    | Medium
    | Large


intToSize : Int -> Size
intToSize n =
    case n of
        1 ->
            Small

        2 ->
            Medium

        _ ->
            Large


generator : Generator Size
generator =
    Random.map intToSize (Random.int 1 3)
