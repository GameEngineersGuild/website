module Config.Episode exposing (..)
import Data.Episode exposing (..)


entries : List Episode
entries =
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