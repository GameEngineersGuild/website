module Main exposing (..)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)

import Html.Events exposing (onClick)
import Url exposing (..)

-- Main

main =
    Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type alias Episode =
    {
        title: String,
        filename: String
    }

type alias Model =
    { count: Int
    , weeklyUpdateEpisodes: List Episode
    }


init : Model
init =
    { count = 0
    , weeklyUpdateEpisodes =
        [{ title = "Update 2020/11/18", filename = "2020-11-18 12-06-35.mp3" }
        , { title = "Update 2020/11/11", filename = "2020-11-11 2012-08-20.mp3" }
        , { title = "Update 2020/10/07", filename = "2020-10-07 12-02-53.mp3" }
        , { title = "Update 2020/09/30", filename = "2020-09-30 12-08-01.mp3" }
        , { title = "Update 2020/09/23", filename = "2020-09-23 12-04-34.mp3" }
        ]
    }

--weeklyEpisodes = ["2020-11-11%2012-08-20.mp3"]

-- UPDATE

type Msg
    = NoOp
    | Increment
    | Decrement
    | Reset

update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model
        Increment ->
            { count = model.count + 1, weeklyUpdateEpisodes = model.weeklyUpdateEpisodes }

        Decrement ->
            { count = model.count - 1, weeklyUpdateEpisodes = model.weeklyUpdateEpisodes }

        Reset ->
            { count = 0, weeklyUpdateEpisodes = model.weeklyUpdateEpisodes }


renderListItem : Episode -> Html Msg
renderListItem item =
    let url = "http://gameengineersguild.org/weekly-roundup/archive/"++item.filename in
        a [ href url, class "list-group-item", target "_blank" ] [ text item.title ]

-- View

view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "page-header" ]
            [ h1 [] [ text "Welcome ", small [] [ text "to the Guild" ] ]
            ]
        , h2 [] [ text "GEG Weekly Roundup" ]
        , p [] [ text "Every week (usually), Guild Members meet to talk about interesting findings, projects and industry news" ]
        , ul [ class "list-group" ]
            (List.map renderListItem model.weeklyUpdateEpisodes)
            --[ list "2020-11-11%2012-08-20.mp3"
            --
            --]
            --[ let url = "http://gameengineersguild.org/weekly-roundup/archive/"++"2020-11-11%2012-08-20.mp3" in
            --    a [ href url, class "list-group-item list-group-item-success", target "_blank" ] [ text "Latest Episode" ]
            --]
        , h2 [] [ text "Guild Member Projects" ]
        , p [] [ text "Under Construction, check back here soon!" ]
        , ul [ class "list-group" ]
            [ a [ href "#", class "list-group-item list-group-item-warning" ] [ text "This Website!" ]
            ]
        -- Fun interactivity
        , div [ class "input-group" ]
            [ span [ class "input-group-btn" ]
                [ button [ class "btn btn-default", onClick Increment ] [ text "+" ]
                ]
            , input [ class "form-control", value (String.fromInt model.count) ] [  ]
            , span [ class "input-group-btn" ]
                [ button [ class "btn btn-default", onClick Reset ] [ text "Reset" ]
                ]
            ]
        ]
