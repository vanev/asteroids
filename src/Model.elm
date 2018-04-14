module Model exposing (Model, withNoCmd, withCmd, initial, onTick, onKeyMsg, onNewAsteroid)

import Physics.Distance exposing (meter)
import Ship exposing (Ship)
import Asteroid exposing (Asteroid)
import Laser exposing (Laser)
import Keyboard.Extra exposing (Key(..))
import Msg exposing (Msg)
import Time exposing (Time, minute, second)


type alias Model =
    { ship : Ship
    , asteroids : List Asteroid
    , pressedKeys : List Key
    , lasers : List Laser
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
    , lasers = []
    }
        |> withNoCmd


weaponsAreFiring : List Key -> Ship -> Bool
weaponsAreFiring pressedKeys ship =
    List.member Space pressedKeys && Ship.weaponsReady ship


createLaser : Ship -> Laser
createLaser ship =
    Laser ship.position ship.direction (0.5 * second)


addLaserIfFiring : List Key -> Ship -> List Laser -> List Laser
addLaserIfFiring pressedKeys ship lasers =
    if weaponsAreFiring pressedKeys ship then
        lasers ++ [ createLaser ship ]
    else
        lasers


onTick : Time -> Model -> Model
onTick diff model =
    let
        ship =
            Ship.onTick diff model.pressedKeys model.ship
                |> (\ship ->
                        if List.any (Asteroid.collidesWith ship.position) model.asteroids then
                            { ship | hitPoints = 0 }
                        else
                            ship
                   )

        asteroids =
            List.map (Asteroid.onTick diff) model.asteroids
                |> List.map
                    (\asteroid ->
                        if List.any (\laser -> Asteroid.collidesWith laser.position asteroid) model.lasers then
                            { asteroid | hitPoints = 0 }
                        else
                            asteroid
                    )
                |> List.filter Asteroid.isAlive

        lasers =
            model.lasers
                |> addLaserIfFiring model.pressedKeys model.ship
                |> List.map (Laser.onTick diff)
                |> List.filter Laser.isAlive
    in
        { model
            | ship = ship
            , asteroids = asteroids
            , lasers = lasers
        }


onKeyMsg : Keyboard.Extra.Msg -> Model -> Model
onKeyMsg keyMsg model =
    { model
        | pressedKeys = Keyboard.Extra.update keyMsg model.pressedKeys
    }


onNewAsteroid : Asteroid -> Model -> Model
onNewAsteroid asteroid model =
    { model | asteroids = model.asteroids ++ [ asteroid ] }
