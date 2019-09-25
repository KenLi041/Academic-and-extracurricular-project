module Grades1 exposing (..)

import Debug
import Html
import Html.Attributes as Attrs


type alias Assignment =
    { name : String
    , points : Int
    , maxPoints : Int
    }


type alias Class =
    { student : String
    , name : String
    , gradePercentage : Float
    , letterGrade : String
    , assignments : List Assignment
    }


grades : List Class
grades =
    [ { student =
            "Jay Sambuco"
      , name = "CL Computer Science"
      , gradePercentage = 86.7
      , letterGrade = "B"
      , assignments =
            [ { name = "HTML/CSS"
              , points = 9
              , maxPoints = 10
              }
            , { name = "Recursive Unions"
              , points = 7
              , maxPoints = 10
              }
            , { name = "Elm Types"
              , points = 10
              , maxPoints = 10
              }
            ]
      }
    , { student =
            "Jay Sambuco"
      , name = "Algebra II Advanced"
      , gradePercentage = 83.3
      , letterGrade = "B"
      , assignments =
            [ { name = "PS 3"
              , points = 9
              , maxPoints = 10
              }
            , { name = "PS 2"
              , points = 8
              , maxPoints = 10
              }
            , { name = "PS 1"
              , points = 8
              , maxPoints = 10
              }
            ]
      }
    , { student =
            "Jay Sambuco"
      , name = "Logic"
      , gradePercentage = 90.0
      , letterGrade = "A-"
      , assignments =
            [ { name = "Natural Deduction"
              , points = 10
              , maxPoints = 10
              }
            , { name = "Godel"
              , points = 8
              , maxPoints = 10
              }
            ]
      }
    ]



-- The values below this line are for Assignment 6


oneClass : Class
oneClass =
    { student =
        "Jay Sambuco"
    , name = "Logic"
    , gradePercentage = 90.0
    , letterGrade = "A-"
    , assignments =
        [ { name = "Natural Deduction"
          , points = 10
          , maxPoints = 10
          }
        , { name = "Godel"
          , points = 8
          , maxPoints = 10
          }
        ]
    }


manyAssignments : List Assignment
manyAssignments =
    [ { name = "HTML/CSS"
      , points = 9
      , maxPoints = 10
      }
    , { name = "Recursive Unions"
      , points = 7
      , maxPoints = 10
      }
    , { name = "Elm Types"
      , points = 10
      , maxPoints = 10
      }
    ]


oneAssignment : Assignment
oneAssignment =
    { name = "Godel"
    , points = 8
    , maxPoints = 10
    }


viewAssignment : Assignment -> Html.Html msg
viewAssignment assign =
    Html.li []
        [ Html.text (assign.name)
        , Html.p
            []
            [ Html.text (toString (assign.points) ++ "/" ++ toString (assign.maxPoints)) ]
        ]


viewAssignments : List Assignment -> Html.Html msg
viewAssignments assigns =
    (Html.ul
        []
        (List.map
            viewAssignment
            assigns
        )
    )


viewClass : Class -> Html.Html msg
viewClass aclass =
    (Html.div []
        [ Html.text (aclass.student)
        , Html.p [] [ Html.text (aclass.name) ]
        , Html.p [] [ Html.text (toString (aclass.gradePercentage)) ]
        , Html.text (aclass.letterGrade)
        , viewAssignments
            (aclass.assignments)
        ]
    )


viewClasses : List Class -> Html.Html msg
viewClasses classes =
    (Html.div
        []
        (List.map
            viewClass
            classes
        )
    )


main : Html.Html msg
main =
    viewClasses grades
