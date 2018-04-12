module Model exposing (Model, withNoCmd, withCmd, initial, onTick, onKeyMsg, onNewAsteroid)

import Ship exposing (Ship)
import Asteroid exposing (Asteroid)
import Keyboard.Extra exposing (Key)
import Msg exposing (Msg)
import Time exposing (Time)


type alias Model =
    { ship : Ship
    , asteroids : List Asteroid
    , pressedKeys : List Key
    }


withNoCmd : Model -> ( Model, Cmd Msg )
withNoCmd model =
    ( model, Cmd.none )


withCmd : Cmd Msg -> Model -> ( Model, Cmd Msg )
withCmd cmd model =
    ( model, cmd )


initial : ( Model, Cmd Msg )
initial =
    { ship = Ship.initial
    , asteroids = []
    , pressedKeys = []
    }
        |> withNoCmd


onTick : Time -> Model -> Model
onTick diff model =
    { model
        | ship = Ship.onTick diff model.pressedKeys model.ship
        , asteroids = List.map (Asteroid.onTick diff) model.asteroids
    }


onKeyMsg : Keyboard.Extra.Msg -> Model -> Model
onKeyMsg keyMsg model =
    { model
        | pressedKeys = Keyboard.Extra.update keyMsg model.pressedKeys
    }


onNewAsteroid : Asteroid -> Model -> Model
onNewAsteroid asteroid model =
    { model | asteroids = model.asteroids ++ [ asteroid ] }
