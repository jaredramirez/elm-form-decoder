module View exposing
    ( View
    , apply
    , map
    , div
    , text
    )

{-| Main framework for managing paddings.


# Core

@docs View
@docs apply
@docs map


# Helper functions for Html

@docs div
@docs text

-}

import Html exposing (Attribute, Html)
import View.Internal as Internal exposing (NoPadding)


{-| Html alternative that is aware of padding width in type level.
-}
type alias View padding msg =
    Internal.View padding msg


{-|

    import Html exposing (div)
    import NoPadding exposing (NoPadding)

    atom1 : View NoPadding msg
    atom1 =
        NoPadding.fromHtml <|
            div
                []
                [ text "atom1"
                ]

    atom2 : View NoPadding msg
    atom2 =
        NoPadding.fromHtml <|
            div
                []
                [ text "atom2"
                ]

    apply (div [])
        [ atom1
        , atom2
        ]

-}
apply : (List (Html a) -> Html b) -> List (View padding a) -> View padding b
apply f ls =
    Internal.fromHtml <| f <| List.map Internal.toHtml ls


{-| -}
map : (Html a -> Html b) -> View padding a -> View padding b
map =
    Internal.map



-- Helper functions for Html


{-| -}
div : List (Attribute msg) -> List (View padding msg) -> View padding msg
div =
    apply << Html.div


{-| -}
text : String -> View NoPadding msg
text =
    Internal.fromHtml << Html.text
