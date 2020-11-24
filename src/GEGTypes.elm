module GEGTypes exposing (..)

type alias Episode =
    {
        title: String,
        recordingDate: String,
        filename: String,
        description: String
    }

-- repostatus.org
type ProjectStatus =
    Active
    | Concept
    | WIP
    | Suspended
    | Abandoned
    | Inactive
    | Unsupported
    | Moved

type alias Project =
    { name: String
    , description: String
    , url: String
    , status: ProjectStatus
    }

type alias GuildMember = 
    { displayName: String
    }