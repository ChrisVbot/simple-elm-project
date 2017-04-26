module MoreForms exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Regex exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



--MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    }



--using type alias as constructor function


model : Model
model =
    Model "" "" "" ""



--UPDATE
{--
    We expect that each of these fields can be changed separately, so our messages should account for each of those
    scenarios.
--}


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age number ->
            { model | age = number }



--VIEW
{--
    For the last child, we do not directly use an HTML function. Instead, we call the viewValidation
    function, passing in the current model.
--}


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name" ] []
        , input [ type_ "password", placeholder "Password" ] []
        , input [ type_ "password", placeholder "Password again" ] []
        , input [ type_ "text", placeholder "Age" ] []

        -- , button [ onClick checkValidators ] [ text "Submit" ]
        , viewValidation model
        ]



-- checkValidators: Model -> Html msg
-- checkValidators model =
{--
    Compares the two passwords and sets inline styles using a tuple.
--}


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if String.length model.password < 8 then
                ( "red", "Password must be 8 characters or more" )
            else if not (Regex.contains (regex "[A-Z]+") model.password) then
                ( "red", "Password must contain at least one capital letter" )
            else if not (Regex.contains (regex "[a-z]+") model.password) then
                ( "red", "Password must contain at least one lowercase letter" )
            else if not (Regex.contains (regex "\\d") model.password) then
                ( "red", "Password must contain at least one digit" )
            else if not (Regex.contains (regex "\\d") model.age) then
                ( "red", "Age must be a number" )
            else if model.password == model.passwordAgain then
                ( "green", "OK" )
            else
                ( "red", "Passwords do not match" )
    in
        div [ style [ ( "color", color ) ] ] [ text message ]
