module Model exposing (Model, withNoCmd, withCmd, initial, onTick, onKeyMsg)

import Ship exposing (Ship)
import Keyboard.Extra exposing (Key)
import Msg exposing (Msg)
import Time exposing (Time)


type alias Model =
    { ship : Ship
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
    , pressedKeys = []
    }
        |> withNoCmd


onTick : Time -> Model -> Model
onTick diff model =
    { model
        | ship = Ship.onTick diff model.pressedKeys model.ship
    }


onKeyMsg : Keyboard.Extra.Msg -> Model -> Model
onKeyMsg keyMsg model =
    { model
        | pressedKeys = Keyboard.Extra.update keyMsg model.pressedKeys
    }
