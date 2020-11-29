module Main exposing (..)

import Json.Decode as Decode exposing (Value)

import Browser exposing (..)
import Browser.Navigation as Nav

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Svg.Attributes exposing (..)

import Route exposing (..)
import Browser exposing (UrlRequest)

import Page exposing (Page)
import Page.Home as Home
import Page.NotFound as NotFound
import Page.Blank as Blank

import Browser.Navigation exposing (Key)

import Url exposing (..)
import Ports exposing (setStorage)

import AppData exposing (AppData)
import AppData.Session exposing (Session)

import Page.Home as Home

type Model 
    = Redirect Session
    | NotFound Session
    | Home Home.Model

type Msg
    = ChangedUrl Url
    | ClickedLink UrlRequest
    | GotHomeMsg Home.Msg
-- Main
 
main : Program Value Model Msg
main =
    Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    , onUrlRequest = ClickedLink
    , onUrlChange = ChangedUrl
    }

init : Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init appData url navKey =
    changeRouteTo (Route.fromUrl url)
        (Redirect (AppData.Session.fromViewer navKey))

-- VIEW


view : Model -> Document Msg
view model =
    let
        viewPage page toMsg config =
            let
                { title, body } =
                    Page.view page config
            in
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        Redirect _ ->
            Page.view Page.Other Blank.view

        NotFound _ ->
            Page.view Page.Other NotFound.view

        Home home ->
            viewPage Page.Home GotHomeMsg (Home.view home)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of 
        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            -- If we got a link that didn't include a fragment,
                            -- it's from one of those (href "") attributes that
                            -- we have to include to make the RealWorld CSS work.
                            --
                            -- In an application doing path routing instead of
                            -- fragment-based routing, this entire
                            -- `case url.fragment of` expression this comment
                            -- is inside would be unnecessary.
                            ( model, Cmd.none )

                        Just _ ->
                            ( model
                            , Nav.pushUrl (AppData.Session.navKey (toSession model)) (Url.toString url)
                            )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( GotHomeMsg subMsg, Home home ) ->
            Home.update subMsg home
                |> updateWith Home GotHomeMsg model
        
        ( _, _ ) ->
            -- Disregard messages that arrived for the wrong page.
            ( model, Cmd.none )

-- Bubbling down sub message to sub model
updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )

toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            session

        NotFound session ->
            session

        Home home ->
            Home.toSession home

changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just Route.Root ->
            ( model, Route.replaceUrl (AppData.Session.navKey session) Route.Home )

        Just Route.Home ->
            Home.init session
                |> updateWith Home GotHomeMsg model