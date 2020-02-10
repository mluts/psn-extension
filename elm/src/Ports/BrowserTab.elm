port module Ports.BrowserTab exposing (..)

import Json.Encode as E


port activeTabExecuteScript : E.Value -> Cmd msg


port activeTabScriptResult : (E.Value -> msg) -> Sub msg


getPSNWishlistItems =
    activeTabExecuteScript <|
        E.object
            [ ( "code", E.string "wishlistItems()" )
            , ( "id", E.string "wishlistItems" )
            ]
