module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, label, hr)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

main =
  Browser.sandbox { init = newTurn, update = update, view = view }

type Bucket = Actions | Buys | Monies

type Msg = Increment Bucket | Decrement Bucket | NewTurn

type alias Model = { actions : Int, buys : Int, monies : Int }

newTurn : Model
newTurn = { actions=1, buys=1, monies=0 }

update msg model =
  case msg of
    Increment Actions -> {model | actions = model.actions + 1}
    Decrement Actions -> {model | actions = model.actions - 1}

    Increment Buys -> {model | buys = model.buys + 1}
    Decrement Buys -> {model | buys = model.buys - 1}

    Increment Monies -> {model | monies = model.monies + 1}
    Decrement Monies -> {model | monies = model.monies - 1}

    NewTurn -> newTurn

view model =
  div
    [ style "display" "flex"
    , style "flex-direction" "column"
    , style "justify-content" "space-between"
    , style "height" "90vh"
    , style "margin-top" "5vh"
    ]
    [ viewBucketCounter "Actions" model.actions Actions
    , viewBucketCounter "Buys" model.buys Buys
    , viewBucketCounter "Monies" model.monies Monies
    , hr [] []
    , bigButton NewTurn "New Turn"
    ]

viewBucketCounter bucketName count bucket =
  div
    [ style "display" "flex"
    , style "flex-direction" "row"
    , style "justify-content" "space-around"
    ]
    [ bigLabel bucketName
    , bigButton (Decrement bucket) "-"
    , bigLabel (String.fromInt count)
    , bigButton (Increment bucket) "+"
    ]

bigLabel lbl =
  label
    [ style "font-size" "6rem"
    ]
    [text lbl]

bigButton action lbl =
 button
   [ onClick action
   , style "min-width" "6rem"
   , style "font-size" "6rem"
   ]
   [ text lbl ]
