module Asteroid exposing (..)

import Physics.Position exposing (Position)
import Physics.Velocity exposing (Velocity)
import Physics.Direction exposing (Direction)
import Physics.Distance exposing (centimeter)
import Physics
import Time exposing (Time, second)
import Random exposing (Generator)
import Asteroid.Size exposing (Size)


type alias Asteroid =
    { position : Position
    , velocity : Velocity
    , direction : Direction
    , size : Size
    }


generator : Generator Asteroid
generator =
    let
        position =
            Physics.Position.generator ( -250, -250 ) ( 250, 250 )

        velocity =
            Physics.Velocity.generator (1 * centimeter / second) (10 * centimeter / second)

        direction =
            Physics.Direction.generator

        size =
            Asteroid.Size.generator
    in
        Random.map4 Asteroid position velocity direction size


onTick : Time -> Asteroid -> Asteroid
onTick time asteroid =
    { asteroid
        | position =
            asteroid.position
                |> Physics.applyVelocityToPosition asteroid.velocity time
                |> Physics.Position.restrict -250 250
    }
