module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram { model = 0, view = view, update = update }


type Msg
    = Increment
    | Decrement
    | Reset


update : Msg -> Int -> Int
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0



-- VIEW
{--
 view function produces an Html Msg value. This means that it is  a chunk of HTML that can produce
 Msg values. Onclick attributes are set to give out Increment and Decrement values. These will
 get fed directly into our update function, driving our whole app forward.

 Also notice that div and button are just normal Elm functions that take (1) a list of attributes
 and (2) a list of child nodes.

 Since we are using normal Elm functions, we have the full power of the Elm programming language to
 help us build our views [...] No need for a templating language.

 Also, the view code is entirely declarative. We take in a Model and produce some Html. No need to
 manipulate the DOM manually since Elm takes care of that behind the scenes.

 This pattern is the essence of the Elm architecture.

--}


view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Reset ] [ text "Reset" ]
        ]
