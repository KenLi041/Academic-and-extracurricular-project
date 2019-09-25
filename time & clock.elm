module CountUp exposing (..)

import Html
import Time
import Date
import Html.Events as Events
import Html.Attributes as Attrs


type alias AppState =
    { secondsLeft : Int, now : Date.Date, textbox : String, paused : Bool }


type AppEvent
    = Tick Time.Time
    | Textboxtochange String
    | Pausedtochange Bool
    | Buttonchange


initialState =
    { now = Date.fromTime 0
    , secondsLeft = 10
    , textbox = " "
    , paused = False
    }


update : AppEvent -> AppState -> AppState
update event state =
    case event of
        Tick currentTime ->
            if state.secondsLeft == 0 then
                { state | now = Date.fromTime currentTime, secondsLeft = 0 }
            else if state.paused == False then
                { state | now = Date.fromTime currentTime, secondsLeft = state.secondsLeft - 1 }
            else if state.paused == True then
                { state | now = Date.fromTime currentTime, secondsLeft = state.secondsLeft }
            else
                state

        Textboxtochange newstate ->
            { state | textbox = newstate }

        Pausedtochange newcheck ->
            { state | paused = newcheck }

        Buttonchange ->
            case stringToMaybeInt state.textbox of
                Just ab ->
                    if ab >= 0 then
                        { state | secondsLeft = ab }
                    else
                        state

                _ ->
                    state


stringToMaybeInt : String -> Maybe Int
stringToMaybeInt s =
    Result.toMaybe (String.toInt s)


subscriptions : AppState -> Sub AppEvent
subscriptions state =
    Time.every Time.second (\t -> Tick t)


inttostring : Int -> String
inttostring a =
    if a < 10 then
        "0" ++ toString (a)
    else
        toString (a)


view : AppState -> Html.Html AppEvent
view state =
    Html.div []
        [ Html.p [] [ Html.text ("Countdown" ++ toString (state.secondsLeft)) ]
        , Html.p [] [ Html.text (toString (datetotime state)) ]
        , Html.p [ Attrs.style [ ( "color", "red" ) ] ]
            [ if state.secondsLeft == 0 then
                Html.text ("Time has running out!")
              else
                Html.text (" ")
            ]
        , Html.input [ Events.onInput (\s -> Textboxtochange s) ] []
        , Html.button [ Events.onClick Buttonchange ] [ Html.text "Start" ]
        , Html.input [ Attrs.type_ "checkbox", Events.onCheck (\b -> Pausedtochange b) ] []
        ]


datetotime : AppState -> Html.Html AppEvent
datetotime state =
    if Date.hour state.now < 12 then
        Html.text (toString (Date.hour state.now) ++ ":" ++ inttostring (Date.minute state.now) ++ ":" ++ inttostring (Date.second state.now) ++ "AM")
    else
        Html.text (toString (Date.hour state.now - 12) ++ ":" ++ inttostring (Date.minute state.now) ++ ":" ++ inttostring (Date.second state.now) ++ "PM")


main =
    Html.program
        { init = ( initialState, Cmd.none )
        , update = \e s -> ( update e s, Cmd.none )
        , view = view
        , subscriptions = subscriptions
        }
