module Homework8 exposing (..)

import Html
import Html.Attributes as Attrs
import Html.Events as Events


type alias AppState =
    { a : String, b : String, c : String }


initialState =
    { a = "", b = "", c = "" }


type AppEvent
    = NewA String
    | NewB String
    | NewC String


update : AppEvent -> AppState -> AppState
update event state =
    case event of
        NewA newA ->
            { state | a = newA }

        NewB newB ->
            { state | b = newB }

        NewC newC ->
            { state | c = newC }


stringToMaybeFloat : String -> Maybe Float
stringToMaybeFloat s =
    Result.toMaybe (String.toFloat s)


semiperimeter a b c =
    (a + b + c) / 2


heron a b c =
    sqrt (semiperimeter a b c * (semiperimeter a b c - a) * (semiperimeter a b c - b) * (semiperimeter a b c - c))


viewResult : AppState -> Html.Html AppEvent
viewResult state =
    case ( stringToMaybeFloat state.a, stringToMaybeFloat state.b, stringToMaybeFloat state.c ) of
        ( Just fa, Just fb, Just fc ) ->
            Html.text (toString (heron fa fb fc))

        ( _, _, _ ) ->
            Html.text "please put the numbers in"


view : AppState -> Html.Html AppEvent
view state =
    Html.div []
        [ Html.div []
            [ Html.input
                [ Events.onInput (\s -> NewA s) ]
                []
            , Html.input
                [ Events.onInput (\s -> NewB s) ]
                []
            , Html.input
                [ Events.onInput (\s -> NewC s) ]
                []
            ]
        , viewResult state
        ]


main =
    Html.beginnerProgram
        { model = initialState
        , view = view
        , update = update
        }
