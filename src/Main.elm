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
        recordingDate: String,
        filename: String,
        description: String
    }

type ProjectStatus =
    Active

type alias Project =
    { name: String
    , description: String
    , url: String
    , status: ProjectStatus
    }

type alias GuildMember = 
    { displayName: String
    }

type alias Model =
    { count: Int
    , weeklyUpdateEpisodes: List Episode
    , projects: List Project
    , guildMembers: List GuildMember
    }


init : Model
init =
    { count = 0
    , weeklyUpdateEpisodes =
        [{ title = "We have a Website!"
            , recordingDate = "2020/11/18"
            , filename = "2020-11-18 12-06-35.mp3"
            , description = """In this episode, we talk about the new website, the Game Engineers' Guild, 
            the Elm programming language and all the related Elixir, Erlang. 
            Generally just fascinated by programming languages that start with the letter "E".
            """
        }
        , { title = "How to Model Complexity"
            , recordingDate = "2020/11/11"
            , filename = "2020-11-11 12-08-20.mp3"
            , description = """In this episode, we talk about the Alloy programming language and high-level modeling
            for complex systems.
            """
        }
        , { title = "What is NVidia's Omniverse?"
            , recordingDate = "2020/10/07"
            , filename = "2020-10-07 12-02-53.mp3" 
            , description = """In this episode, we explore NVidia's Omniverse and try to look past the buzzwords."""
        }
        , { title = "How to Improve Asset Pipelines"
            , recordingDate = "2020/09/30"
            , filename = "2020-09-30 12-08-01.mp3"
            , description = """In this episode, we talk about how to improve Asset Pipelines for games."""
        }
        , { title = "How to Quantum?"
            , recordingDate = "2020/09/23"
            , filename = "2020-09-23 12-04-34.mp3"
            , description = """In this episode, we talk about Quantum Mechanics, Quantum Computings and Quantum Consciousness.
            Basically a bunch of topics that game engineers shouldn't talk about with any authority."""
        }
        ]
    , projects = 
        [{ name = "This Website"
            , description = "The official website for the Game Engineers' Guild."
            , url = "https://github.com/GameEngineersGuild/website"
            , status = Active
        }
        , { name = "Phoyeur"
            , description = "A game running on the GameSauce LiveOps Platform"
            , url = "http://gamesauce.bitkitchen.net/phoyeur"
            , status = Active
        }
        ]
    , guildMembers =
        [{ displayName = "Zappy" }
        , { displayName = "ndugu" }
        , { displayName = "JT" }
        , { displayName = "GameDevSam" }
        ]
    }

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
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

        Reset ->
            { model | count = 0 }


renderEpisode : Episode -> Html Msg
renderEpisode episode =
    let url = "http://gameengineersguild.org/weekly-roundup/archive/"++episode.filename in
        a [ href url, class "list-group-item", target "_blank" ] 
        [ h4 [ class "list-group-item-heading" ] [ text episode.title ]
        , div [] 
        [ let recordedText = "Recorded On: "++episode.recordingDate in
            text recordedText
        ]
        , p [ class "list-group-item-text" ]
            [ text episode.description ]
        ]

type alias StatusLabel =
    { cssClass: String
    , text: String
    }

getLabelColorForStatus : ProjectStatus -> StatusLabel
getLabelColorForStatus status =
 case status of
    Active -> 
        { cssClass = "label-success", text = "Active" }

renderProjectStatusLabel : ProjectStatus -> Html Msg
renderProjectStatusLabel status = 
    let statusLabel = getLabelColorForStatus status in 
    span [
        let classes = "label "++statusLabel.cssClass in
        class classes ] 
        [
            text statusLabel.text
        ]

renderProject : Project -> Html Msg
renderProject project =
    a [ href project.url, class "list-group-item", target "_blank" ] 
    [ h4 [ class "list-group-item-heading" ]
        [ text project.name ]
    , p [ class "list-group-item-text" ]
        [ text project.description ]
    , renderProjectStatusLabel project.status
    ]

renderGuildMember : GuildMember -> Html Msg
renderGuildMember guildMember =
    a [ href "#", class "list-group-item list-group-item-success" ] 
        [ text guildMember.displayName 
        ]
-- View

view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "page-header" ]
            [ h1 [] [ text "It's like Devchat ", small [] [ text "but across the Game Industry" ] ]
            ]
        , div [ class "row" ] 
        [ div [ class "col-md-3" ]
            [ h3 [] 
                [ text "Guild Members"
                ]
            , p [] [ text "Official members and contributors to the Guild Projects" ]
            , ul [ class "list-group" ]
                (List.map renderGuildMember model.guildMembers)
            , h3 [] [ text "Guild Member Projects" ]
            , p [] [ text "Projects developed by Guild Members" ]
            , ul [ class "list-group" ]
                (List.map renderProject model.projects)
            ]
        , div [ class "col-md-9" ]
            [ h3 [] [ text "GEG Weekly Roundup" ]
            , p [] [ text "Every week (usually), Guild Members meet to talk about interesting findings, projects and industry news" ]
            , ul [ class "list-group" ]
                (List.map renderEpisode model.weeklyUpdateEpisodes)
            ]
        ]
        
        -- Fun interactivity
        , div [ class "row" ]
        [ h3 [] [ text "Games" ]
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
        ]
