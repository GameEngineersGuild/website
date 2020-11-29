module Page.Home exposing (..)
import Config.Episode as Episode
import Config.GuildMember as GuildMember
import Config.Project as Project

import AppData exposing (..)

import Data.Episode exposing (..)
import Data.GuildMember exposing (..)
import Data.Project exposing (..)

import Ports exposing (setStorage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Browser exposing (..)

import AppData.Session exposing (..)


-- MODEL
type alias Model =
    { session: Session
    , redHounds: Int
    , sessionPets: Int
    , weeklyUpdateEpisodes: List Episode
    , projects: List Project
    , guildMembers: List GuildMember
    }


toSession : Model -> Session
toSession model =
    model.session

init : Session -> ( Model, Cmd msg )
init session =
    ({ session = session 
    , redHounds = 0
    , sessionPets = 0
    , weeklyUpdateEpisodes = Episode.entries
    , projects = Project.entries
    , guildMembers = GuildMember.entries
    }, Cmd.none
    )

-- UPDATE

type Msg
    = NoOp
    | GainRedhound
    | PetDoggo
    | BigDoggoPet


{-| We want to `setStorage` on every update. This function adds the setStorage
command for every step of the update function.
-}
updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg model =
    let
        ( newModel, cmds ) =
            update msg model
    in
        ( newModel
        , Cmd.batch [ setStorage newModel.redHounds, cmds ]
        )
        
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        GainRedhound ->
            (   { model 
                | redHounds = model.redHounds + 1 
                }
            , Cmd.none 
            )
        PetDoggo -> 
            ( { model 
                | redHounds = model.redHounds - 1, sessionPets = model.sessionPets + 1
                }
            , Cmd.none
            )
        BigDoggoPet -> 
            ( { model 
                | redHounds = model.redHounds - 10, sessionPets = model.sessionPets + 10
                }
            , Cmd.none
            )


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
    Inactive -> 
        { cssClass = "label-default", text = "Inactive" }
    _ -> 
        { cssClass = "label-default", text = "TBD" }

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

view : Model -> { title : String, content : Html Msg }
view model 
    = { title = "Home"
        , content =
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
            , br [] []
            , h3 [] [ text "Games" ]
            , div [ class "row" ]
            [ div [ class "col-md-6" ]
                [ p [] 
                    [ text "Stored in your browser's local storage:"
                    , code [] [ text "geg-redhounds" ] ]
                , renderPetDoggo model.redHounds
                , renderDoggoPetResponse model.sessionPets
                ]
            , br [] []
            ]
        ]
    }

renderDoggoPetResponse : Int -> Html Msg
renderDoggoPetResponse numPets = 
    div [] 
    [ if numPets == 1 then
        p [] [ text "Doggo loved the pet" ]
    else if numPets > 1 then
        -- let numPets = String.fromInt model.sessionPets in
        let petText = "Doggo loved the "++(String.fromInt numPets)++" pets" in
        p [] [ text petText ]
    else Html.text ""
    , if numPets >= 10 then 
        p [] [ text "Omg, so many pets! "]
    else Html.text ""
    , if numPets >= 69 then 
        p [] [ text "Nice"]
    else Html.text ""
    , if numPets >= 100 then 
        p [] [ text "Too many pets! I can't even react!"]
    else Html.text ""
    ]

renderPetDoggo : Int -> Html Msg
renderPetDoggo redHounds =
    div [ class "input-group" ]
    [ span [ class "input-group-btn" ]
        [ button [ class "btn btn-success", onClick GainRedhound ] [ text "Gain a Redhound (RH)" ]
        ]
    , input [ class "form-control", disabled True, value (String.fromInt redHounds) ] [  ]
    , if redHounds >= 1 then 
        span [ class "input-group-btn" ]
        [ button [ class "btn btn-warning", onClick PetDoggo ] [ text "Pet Doggo (1 RH)" ] ]
    else
        Html.text ""
    , if redHounds >= 10 then 
        span [ class "input-group-btn" ]
        [ button [ class "btn btn-danger", onClick BigDoggoPet ] [ text "Big Doggo Pet (10 RH)" ] ]
    else
        Html.text ""
    ]