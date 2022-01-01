module MyPage exposing (..)

import Html
import Html.Attributes as Attrs


main : Html.Html msg



--main = Html.p [] [Html.text "A paragraph"]


main = Html.div [] [ Html.h1 [] [ Html.text "heading" ], Html.p [ Attrs.style [ ( "color", "blue" ), ( "font-size", "22pt" ) ] ] [ Html.text "a paragraph" ] ]


times =
    [ 12, 13, 14, 67, 68 ]

timeToItem: Float -> Html.Html msg
timeToItem t = 
    Html.li [][ Html.text t (toString t)]

main = Html.ul [](List.map timeToItem times)
timeStyle: Float -> HtmlAttribute msg
timeStyle t = if t = times then 
