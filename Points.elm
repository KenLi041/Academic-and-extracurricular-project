module Points exposing (..)

import Html
import Html.Attributes as Attrs
import Debug


type alias Point =
    { x : Float
    , y : Float
    }


points : List Point
points =
    [ { x = -1.0, y = 0.5 }
    , { x = 0.0, y = 1.0 }
    , { x = 1.0, y = 2.0 }
    , { x = 2.0, y = 4.0 }
    , { x = 3.0, y = 8.0 }
    , { x = 4.0, y = 16.0 }
    ]


border : Html.Attribute msg
border =
    Attrs.style
        [ ( "border-bottom-style", "solid" ) ]


flexRowStyle : Html.Attribute msg
flexRowStyle =
    Attrs.style
        [ ( "display", "flex" )
        , ( "flex-direction", "row" )
        ]


flexColumnStyle : Html.Attribute msg
flexColumnStyle =
    Attrs.style
        [ ( "display", "flex" )
        , ( "flex-direction", "column" )
        ]


tableCellStyle : Html.Attribute msg
tableCellStyle =
    Attrs.style
        [ ( "width", "30px" )
        , ( "height", "1.5em" )
        , ( "text-align", "center" )
        ]


row : Point -> Html.Html msg
row p =
    Html.div [ flexRowStyle ]
        [ Html.div [ tableCellStyle ]
            [ Html.text (toString p.x)
            ]
        , Html.div [ tableCellStyle ]
            [ Html.text (toString p.y)
            ]
        ]


header : Html.Html msg
header =
    Html.div [ flexRowStyle, border ]
        [ Html.div [ tableCellStyle ] [ Html.text "x" ]
        , Html.div [ tableCellStyle ] [ Html.text "y" ]
        ]


main =
    Html.div [ flexColumnStyle ]
        (header
            :: (List.map row points)
        )
