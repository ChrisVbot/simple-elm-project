module MoreForms exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Regex exposing (regex)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



--MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    , errors : List String
    }



--using type alias as constructor function


model : Model
model =
    Model "" "" "" "" []



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
    | Errors


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

        Errors ->
            { model | errors = detectValidationErrors model }



--VIEW
{--
    For the last child, we do not directly use an HTML function. Instead, we call the viewValidation
    function, passing in the current model.
--}


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Password again", onInput PasswordAgain ] []
        , input [ type_ "text", placeholder "Age", onInput Age ] []
        , button [ onClick Errors ] [ text "Check for errors" ]
        , validate model
        ]



-- Grabs errors from model record and generates li for each error


validate : Model -> Html msg
validate { errors } =
    let
        errorListItems =
            List.map (\errorMsg -> li [ style [ ( "color", "red" ) ] ] [ text errorMsg ])
                errors
    in
        ul [] errorListItems


type alias Validation =
    { condition : Bool
    , errorMessage : String
    }



-- Detects errors by using Validation type alias as a constructor function


detectValidationErrors : Model -> List String
detectValidationErrors { name, password, passwordAgain, age } =
    let
        validations =
            [ Validation (String.length name < 2) "Name must be at least 2 characters"
            , Validation (String.length password < 8) "Password must be at least 8 characters"
            , Validation (String.contains "!" password) "! is a forbidden character"
            , Validation (password /= passwordAgain) "Passwords do not match"
            , Validation (not (Regex.contains (regex "[A-Z]+") password)) "Password must contain one capital letter"
            , Validation (not (Regex.contains (regex "[a-z]+") password)) "Password must contain one lowercase letter"
            , Validation (not (Regex.contains (regex "\\d") password)) "Password must contain at least one digit"
            , Validation (not (Regex.contains (regex "\\d") age)) "Age must be a number"
            ]

        validationErrorMessages =
            validations
                --keeps only those elements for which the function returns True
                |> List.filter .condition
                -- maps out new list with one entry for record in list containing .errorMessage field
                -- which all have .condition = True at this point
                |> List.map .errorMessage
    in
        -- returns new list created from above filtering and mapping
        validationErrorMessages
