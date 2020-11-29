module AppData.Session exposing (..)

import Browser.Navigation as Nav

-- TYPES

type Session
    = Guest Nav.Key


navKey : Session -> Nav.Key
navKey session =
    case session of
        Guest key ->
            key
-- INFO


-- viewer : Session -> Maybe Viewer
-- viewer session =
--     case session of

--         Guest _ ->
--             Nothing

-- CHANGES


-- changes : (Session -> msg) -> Nav.Key -> Sub msg
-- changes toMsg key =
--     Api.viewerChanges (\maybeViewer -> toMsg (fromViewer key maybeViewer)) Viewer.decoder


fromViewer : Nav.Key -> Session
fromViewer key =
    -- It's stored in localStorage as a JSON String;
    -- first decode the Value as a String, then
    -- decode that String as JSON.
    -- case maybeViewer of
        -- Just viewerVal ->
            -- LoggedIn key viewerVal

        -- Nothing ->
            Guest key