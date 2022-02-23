--Done by Ken Li

module Check exposing (..)

import Html
import Html.Attributes as Attrs
import Html.Events as Events


type alias AppState =
    { checked : Bool
    }


type AppEvent
    = CheckChange Bool


initialState : AppState
initialState =
    { checked = False }


update : AppEvent -> AppState -> AppState
update event state =
    case event of
        CheckChange c ->
            { checked = c }


view : AppState -> Html.Html AppEvent
view state =
    Html.div []
        [ Html.input
            [ Attrs.type_ "checkbox"
            , Events.onCheck (\b -> CheckChange b)
            ]
            []
        , Html.text
            (if state.checked then
                "checked"
             else
                "not checked"
            )
        ]


main =
    Html.beginnerProgram
        { model = initialState
        , update = update
        , view = view
        }
