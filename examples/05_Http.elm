module HttpGiffer exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


--MODEL


type alias Model =
    { topic : String
    , gifUrl : String
    }


init : String -> ( Model, Cmd Msg )
init topic =
    ( Model topic "waiting.gif", getRandomGif topic )



-- UPDATE


type Msg
    = NewTopic String
    | MorePlease
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTopic str ->
            ( { model | topic = str }, Cmd.none )

        MorePlease ->
            ( model, getRandomGif model.topic )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string



-- VIEW


mainStyle : Attribute msg
mainStyle =
    [ ( "textAlign", "center" )
    , ( "marginTop", "100px" )
    ]
        |> style


view : Model -> Html Msg
view model =
    div [ mainStyle ]
        [ h2 [] [ text ("Now showing gif of: " ++ model.topic) ]
        , img [ src model.gifUrl ] []
        , br [] []
        , button [ onClick MorePlease ] [ text "Another!" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , subscriptions = subscriptions
        , init = init "cats"
        }
