module Main exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { content : String }



-- this is our model which will keep track of whatever text user types into the field:


model : Model
model =
    { content = "" }



-- UPDATE
{--
In this app there is only one kind of message. The user can change the contents of the text field
and it will always be a string
--}


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        --only have to handle one case because there's only one kind of message
        Change newContent ->
            --record update syntax
            { model | content = newContent }



-- VIEW
{--
here we are saying how to view our application
--}


view : Model -> Html Msg
view model =
    --creating a div with two children
    div []
        [ input [ placeholder "Text to reverse", onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        ]
