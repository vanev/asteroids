module Physics.Distance exposing (..)


type alias Distance =
    Float


millimeter : Distance
millimeter =
    1


centimeter : Distance
centimeter =
    10 * millimeter


meter : Distance
meter =
    100 * centimeter


inch : Distance
inch =
    2.54 * centimeter


foot : Distance
foot =
    12 * inch


yard : Distance
yard =
    3 * foot


mile : Distance
mile =
    5280 * foot


inMillimeters : Distance -> Distance
inMillimeters d =
    d / millimeter


inCentimeters : Distance -> Distance
inCentimeters d =
    d / centimeter


inMeters : Distance -> Distance
inMeters d =
    d / meter


inInch : Distance -> Distance
inInch d =
    d / inch


inFeet : Distance -> Distance
inFeet d =
    d / foot


inYards : Distance -> Distance
inYards d =
    d / yard


inMiles : Distance -> Distance
inMiles d =
    d / mile
