module Laser exposing (Laser, isAlive, onTick, view)

import Physics.Position exposing (Position)
import Physics.Direction exposing (Direction)
import Physics.Distance exposing (meter)
import Physics.Speed exposing (Speed)
import Physics
import Time exposing (Time, second)
import Msg exposing (Msg)
import Html exposing (Html, text, div)
import Html.Attributes exposing (style)


type alias Laser =
    { position : Position
    , direction : Direction
    , hitPoints : Time
    }


isAlive : Laser -> Bool
isAlive { hitPoints } =
    hitPoints > 0


speed : Speed
speed =
    1 * meter / second


onTick : Time -> Laser -> Laser
onTick time laser =
    { laser
        | position =
            laser.position
                |> Physics.applyVelocityToPosition ( speed, laser.direction ) time
                |> Physics.Position.restrict -250 250
        , hitPoints =
            laser.hitPoints - time
    }


view : Laser -> Html Msg
view { position, direction } =
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
    in
        div
            [ style
                [ ( "position", "absolute" )
                , ( "top", top ++ "px" )
                , ( "left", left ++ "px" )
                , ( "width", "1px" )
                , ( "height", "10px" )
                , ( "backgroundColor", "white" )
                , ( "transform", "rotate(" ++ rotation ++ "rad)" )
                ]
            ]
            []
