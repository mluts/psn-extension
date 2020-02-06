module View exposing (view)

import Browser
import Html
import Html.Events as Attr
import Model exposing (..)
import PSN


downloadCsvBtn =
    Html.button
        [ Attr.onClick DownloadCSV
        ]
        [ Html.text "Download as CSV" ]


appState model =
    [ Html.text
        (if String.isEmpty model.state then
            ""

         else
            "State: " ++ model.state
        )
    , Html.text
        (if String.isEmpty model.error then
            ""

         else
            "Error: " ++ model.error
        )
    , Html.text
        (PSN.wishlistCSV model.wishlistItems)
    ]


view model =
    Browser.Document
        "PSN Wishlist Downloader"
        [ Html.div
            []
            [ downloadCsvBtn ]
        ]
