module Config.Project exposing (..)
import Data.Project exposing (..)

entries : List Project
entries  = 
    [{ name = "This Website"
        , description = """The official website for the Game Engineers' Guild."""
        , url = "https://github.com/GameEngineersGuild/website"
        , status = Active
    }
    , { name = "Phoyeur"
        , description = """A chain match adventure game and testbed for the GameSauce LiveOps Platform."""
        , url = "http://gamesauce.bitkitchen.net/phoyeur"
        , status = Active
    }
    , { name = "ZBuild"
        , description = """A python build system meant to help Unity developers generate multi-platform builds 
        and upload those builds to storefronts, like Itch.io and Steam."""
        , status = Inactive
        , url = "https://github.com/czarzappy/EZBuild"
    }
    ]