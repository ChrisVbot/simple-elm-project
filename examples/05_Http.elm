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
    , prevImages : List String
    , isLoading : Bool
    }


init : String -> ( Model, Cmd Msg )
init topic =
    ( Model topic loadingGifUrl [] False, getRandomGif topic )



-- UPDATE


type Msg
    = NewTopic String
    | MorePlease
    | NewGif (Result Http.Error String)
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTopic str ->
            ( { model | topic = str }, Cmd.none )

        MorePlease ->
            ( { model | prevImages = model.gifUrl :: model.prevImages, isLoading = True }, getRandomGif model.topic )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl, isLoading = False }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )

        Reset ->
            (init "cats")


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


loadingGifUrl : String
loadingGifUrl =
    "../images/animal.gif"


mainStyle : Attribute msg
mainStyle =
    [ ( "textAlign", "center" )
    , ( "marginTop", "100px" )
    ]
        |> style


view : Model -> Html Msg
view model =
    div []
        [ div [ mainStyle ]
            [ input [ placeholder "What you wanna gif?", onInput NewTopic ] []
            , h2 [] [ text model.topic ]
            , case model.isLoading of
                True ->
                    img [ src loadingGifUrl ] []

                False ->
                    img [ src model.gifUrl ] []
            , br [] []
            , button [ onClick MorePlease ] [ text "New gif!" ]
            , button [ onClick Reset ] [ text "Reset" ]
            ]
        , renderImageList model
        ]


renderImageList : Model -> Html Msg
renderImageList { prevImages } =
    let
        imageUrls =
            List.reverse (List.map renderImage prevImages)
    in
        ul
            [ style
                [ ( "display", "flex" )
                , ( "listStyle", "none" )
                , ( "flexDirection", "row" )
                , ( "flexWrap", "wrap" )
                ]
            ]
            imageUrls


renderImage : String -> Html Msg
renderImage imgUrl =
    li
        [ style [ ( "padding", "10px" ) ] ]
        [ img [ src imgUrl ] [] ]


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
