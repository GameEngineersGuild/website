module LocalEntities exposing (..)
import GEGTypes exposing (..)

weeklyUpdateEpisodes : List Episode
weeklyUpdateEpisodes =
    [{ title = "Hotels En Colombia"
    , recordingDate = "2020/12/02"
    , filename = "2020-12-02+12-16-14.mp3"
    , description = """In this episode, we talk about an SSL puzzler. (Audio is a bit messy)
    """
    }
    ,{ title = "We have a Website!"
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


projects : List Project
projects  = 
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
        , description = """A python build system meant to help Unity developers generate multi-platform builds and upload those builds to storefronts, like Itch.io and Steam."""
        , status = Inactive
        , url = "https://github.com/czarzappy/EZBuild"
    }
    ]

guildMembers : List GuildMember
guildMembers = 
    [{ displayName = "Zappy" }
    , { displayName = "aaron" }
    , { displayName = "JT" }
    , { displayName = "GameDevSam" }
    ]