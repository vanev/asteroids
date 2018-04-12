module Asteroid.View exposing (view)

import Asteroid exposing (Asteroid)
import Asteroid.Size exposing (Size(..))
import Physics.Position
import Msg exposing (Msg)
import Html exposing (Html, text, div)
import Html.Attributes exposing (style)


view : Asteroid -> Html Msg
view { position, direction, size } =
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

        diameter =
            case size of
                Small ->
                    10

                Medium ->
                    20

                Large ->
                    30
    in
        div
            [ style
                [ ( "position", "absolute" )
                , ( "top", top ++ "px" )
                , ( "left", left ++ "px" )
                , ( "width", (toString diameter) ++ "px" )
                , ( "height", (toString diameter) ++ "px" )
                , ( "border-radius", "100%" )
                , ( "backgroundColor", "white" )
                , ( "transform", "rotate(" ++ rotation ++ "rad) translate(-50%, -50%)" )
                , ( "transform-origin", "-50% -50%" )
                ]
            ]
            []
