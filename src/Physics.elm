module Physics exposing (..)

import Time exposing (Time)
import Physics.Velocity exposing (Velocity)
import Physics.Position exposing (Position)
import Physics.Speed exposing (Speed)
import Physics.Direction exposing (Direction)
import Physics.Acceleration exposing (Acceleration)


applyVelocityToPosition : Velocity -> Time -> Position -> Position
applyVelocityToPosition velocity time position =
    Physics.Velocity.position time velocity
        |> Physics.Position.add position


applySpeedToDirection : Speed -> Time -> Direction -> Direction
applySpeedToDirection speed time direction =
    direction + (speed * time)


applyAccelerationToVelocity : Acceleration -> Time -> Direction -> Velocity -> Velocity
applyAccelerationToVelocity acceleration time direction velocity =
    Physics.Velocity.add velocity ( (acceleration * time), direction )
