module Record1 exposing (..)


license =
    { hair = "Green", name = "C.C", height = "185", occupation = "witch" }


x =
    5


type Day
    = Sunday
    | Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday


isMonday : Day -> Bool
isMonday d =
    if d == Monday then
        True
    else
        False
isMonday : Day -> Bool
isMonday d =
    case d of
        Monday ->
            True

        _ ->
            False


daysTillFriday : Day -> Bool
daysTillFriday d =
    case d of
        Friday ->
            0

        Thursday ->
            1

        Wednesday ->
            2

        Tuesday ->
            3

        Monday ->
            4

        Sunday ->
            2

        Saturday ->
            1


type MaybeFloat
    = AFloat Float
    | NoFloat


divMF : MaybeFloat -> MaybeFloat -> MaybeFloat
divMF left right =
    case ( left, right ) of
        ( AFloat IsValue, AFloat rsValue ) ->
            if rsValue == 0 then
                NoFloat
            else
                AFloat (IsValue / rsValue)

        _ ->
            NoFloat


sqrtMF : MaybeFloat -> MaybeFloat
sqrtMF mf =
    case mf of
        NoFloat ->
            NoFloat

        AFloat f ->
            if f < 0 then
                NoFloat
            else
                AFloat (f ^ 0.5)
