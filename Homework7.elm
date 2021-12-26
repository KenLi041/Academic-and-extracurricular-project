module ColorButton exposing (..)

import Html
import Html.Attributes as Attrs
import Html.Events as Events


type AppState
    = Red
    | Blue
    | Green


type AppEvent
    = PressRed
    | PressBlue
    | PressGreen


initialState : AppState
initialState =
    Red


red =
    Attrs.style [ ( "color", "red" ) ]


blue =
    Attrs.style [ ( "color", "blue" ) ]


green =
    Attrs.style [ ( "color", "green" ) ]


update : AppEvent -> AppState -> AppState
update event state =
    case event of
        PressRed ->
            Red

        PressBlue ->
            Blue

        PressGreen ->
            Green


colorstyle : AppState -> Html.Attribute AppEvent
colorstyle state =
    case state of
        Red ->
            red

        Blue ->
            blue

        Green ->
            green


view : AppState -> Html.Html AppEvent
view state =
    Html.div []
        [ Html.p []
            [ Html.text ("The color is" ++ " ")
            , Html.span [ colorstyle state ] [ Html.text (toString state) ]
            , Html.button [ Events.onClick PressRed ] [ Html.text "Red" ]
            , Html.button [ Events.onClick PressBlue ] [ Html.text "Blue" ]
            , Html.button [ Events.onClick PressGreen ] [ Html.text "Green" ]
            ]
        ]


main =
    Html.beginnerProgram { model = initialState, view = view, update = update }
