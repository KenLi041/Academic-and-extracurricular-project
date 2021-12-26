module Test exposing (..)


type alias Person =
    { first : String, last : String, age : Int }


type alias Person2 =
    { name : String, age : Int }


convert : Person -> Person2
convert person =
    { name = person.first ++ person.last, age = person.age }


interest : Float -> Float -> Int -> Float -> Float
interest p r c y =
    p * (toFloat (1) + (r / toFloat (c))) ^ toFloat (floor (toFloat (c) * y))


unzip : List ( a, b ) -> ( List a, List b )
unzip list =
    case list of
        [] ->
            ( [], [] )

        ( a, b ) :: t ->
            let
                ( c, d ) =
                    unzip t
            in
                ( a :: c, b :: d )


append : List a -> List a -> List a
append list1 list2 =
    case list1 of
        [] ->
            list2

        [ a ] ->
            a :: list2

        h :: t ->
            h :: append t list2
