module GEGTypes exposing (..)

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