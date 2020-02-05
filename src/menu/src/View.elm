module View exposing (view)

import Browser
import Html
import Html.Events as Attr
import Model exposing (..)


downloadCsvBtn =
    Html.button
        [ Attr.onClick DownloadCSV
        ]
        [ Html.text "Download as CSV" ]


view model =
    Browser.Document
        "PSN Wishlist Downloader"
        [ Html.div
            []
            [ Html.text ("State: " ++ model.state)
            , Html.text
                (if String.isEmpty model.error then
                    ""

                 else
                    "Error: " ++ model.error
                )
            , downloadCsvBtn
            ]
        ]
