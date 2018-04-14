module Asteroid exposing (..)

import Physics.Position exposing (Position)
import Physics.Velocity exposing (Velocity)
import Physics.Direction exposing (Direction)
import Physics.Distance exposing (centimeter)
import Physics
import Time exposing (Time, second)
import Random exposing (Generator)
import Asteroid.Size exposing (Size(..))


type alias Asteroid =
    { position : Position
    , velocity : Velocity
    , direction : Direction
    , size : Size
    , hitPoints : Float
    }


isAlive : Asteroid -> Bool
isAlive { hitPoints } =
    hitPoints > 0


collidesWith : Position -> Asteroid -> Bool
collidesWith target asteroid =
    let
        diameter =
            case asteroid.size of
                Small ->
                    15

                Medium ->
                    25

                Large ->
                    35
    in
        Physics.Position.distance target asteroid.position < diameter


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

        hitPoints =
            Random.float 100 100
    in
        Random.map5 Asteroid position velocity direction size hitPoints


onTick : Time -> Asteroid -> Asteroid
onTick time asteroid =
    { asteroid
        | position =
            asteroid.position
                |> Physics.applyVelocityToPosition asteroid.velocity time
                |> Physics.Position.restrict -250 250
    }
