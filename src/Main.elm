module Main exposing (..)

import Model exposing (Model)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Msg exposing (Msg(..))
import Ship exposing (Ship)
import Asteroid
import Asteroid.View
import AnimationFrame
import Keyboard.Extra
import Random


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
                |> \model ->
                    if List.length model.asteroids < 5 then
                        Model.withCmd (Random.generate NewAsteroid Asteroid.generator) model
                    else
                        Model.withNoCmd model

        KeyMsg keyMsg ->
            model
                |> Model.onKeyMsg keyMsg
                |> Model.withNoCmd

        NewAsteroid asteroid ->
            model
                |> Model.onNewAsteroid asteroid
                |> Model.withNoCmd

        _ ->
            model |> Model.withNoCmd



---- VIEW ----


ship : Model -> Html Msg
ship model =
    div
        [ style
            [ ( "position", "absolute" )
            , ( "width", "100%" )
            , ( "height", "100%" )
            ]
        ]
        [ Ship.view model.ship ]


asteroids : Model -> Html Msg
asteroids model =
    div
        [ style
            [ ( "position", "absolute" )
            , ( "width", "100%" )
            , ( "height", "100%" )
            ]
        ]
        (List.map Asteroid.View.view model.asteroids)


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
        [ ship model
        , asteroids model
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
