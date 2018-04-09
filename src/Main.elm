module Main exposing (..)

import Model exposing (Model)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Msg exposing (Msg(..))
import Ship exposing (Ship)
import AnimationFrame
import Keyboard.Extra


---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.diffs Tick
        , Sub.map KeyMsg Keyboard.Extra.subscriptions
        ]



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick diff ->
            model
                |> Model.onTick diff
                |> Model.withNoCmd

        KeyMsg keyMsg ->
            model
                |> Model.onKeyMsg keyMsg
                |> Model.withNoCmd

        _ ->
            model |> Model.withNoCmd



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "position", "relative" )
            , ( "width", "500px" )
            , ( "height", "500px" )
            , ( "backgroundColor", "black" )
            ]
        ]
        [ Ship.view model.ship
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = Model.initial
        , update = update
        , subscriptions = subscriptions
        }
