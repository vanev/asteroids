module Ship exposing (Ship, initial, weaponsReady, view, onTick)

import Physics
import Physics.Position exposing (Position)
import Physics.Velocity exposing (Velocity)
import Physics.Speed exposing (Speed)
import Physics.Direction exposing (Direction)
import Physics.Acceleration exposing (Acceleration)
import Time exposing (Time, millisecond)
import Physics.Distance
import Msg exposing (Msg)
import Html exposing (Html, text, div)
import Html.Attributes exposing (style)
import Keyboard.Extra exposing (Key(..))


type alias Ship =
    { position : Position
    , direction : Direction
    , velocity : Velocity
    , weaponsCooldown : Time
    , hitPoints : Float
    }


initial : Ship
initial =
    { position = ( 0, 0 )
    , direction = 0
    , velocity = ( 0, 0 )
    , weaponsCooldown = 0
    , hitPoints = 100
    }


weaponsReady : Ship -> Bool
weaponsReady { weaponsCooldown } =
    weaponsCooldown <= 0


rotationSpeed : Speed
rotationSpeed =
    (degrees 270) / Time.second


rotateLeft : Time -> Direction -> Direction
rotateLeft =
    Physics.applySpeedToDirection (rotationSpeed * -1)


rotateRight : Time -> Direction -> Direction
rotateRight =
    Physics.applySpeedToDirection rotationSpeed


acceleration : Acceleration
acceleration =
    ((10 * Physics.Distance.centimeter) / Time.second) / Time.second


accelerate : Time -> Direction -> Velocity -> Velocity
accelerate =
    Physics.applyAccelerationToVelocity acceleration


decelerate : Time -> Direction -> Velocity -> Velocity
decelerate =
    Physics.applyAccelerationToVelocity (acceleration * -1)


onTick : Time -> List Key -> Ship -> Ship
onTick time pressedKeys ship =
    let
        direction =
            if List.member ArrowRight pressedKeys then
                rotateRight time ship.direction
            else if List.member ArrowLeft pressedKeys then
                rotateLeft time ship.direction
            else
                ship.direction

        velocity =
            if List.member ArrowUp pressedKeys then
                accelerate time ship.direction ship.velocity
            else if List.member ArrowDown pressedKeys then
                decelerate time ship.direction ship.velocity
            else
                ship.velocity

        position =
            ship.position
                |> Physics.applyVelocityToPosition velocity time
                |> Physics.Position.restrict -250 250

        weaponsCooldown =
            if ship.weaponsCooldown > 0 then
                ship.weaponsCooldown - time
            else if List.member Space pressedKeys then
                250 * millisecond
            else
                0
    in
        { ship
            | position = position
            , direction = direction
            , velocity = velocity
            , weaponsCooldown = weaponsCooldown
        }


view : Ship -> Html Msg
view { position, direction, hitPoints } =
    let
        top =
            position
                |> Physics.Position.x
                |> (*) -1
                |> (+) 250
                |> toString

        left =
            position
                |> Physics.Position.y
                |> (+) 250
                |> toString

        rotation =
            direction
                |> toString

        color =
            if hitPoints <= 0 then
                "red"
            else
                "white"
    in
        div
            [ style
                [ ( "position", "absolute" )
                , ( "top", top ++ "px" )
                , ( "left", left ++ "px" )
                , ( "width", "20px" )
                , ( "height", "20px" )
                , ( "color", color )
                , ( "fontSize", "20px" )
                , ( "lineHeight", "20px" )
                , ( "fontWeight", "bold" )
                , ( "transform", "rotate(" ++ rotation ++ "rad) translate(-50%, -50%)" )
                , ( "transform-origin", "0 0" )
                ]
            ]
            [ text "∆" ]
