module Model exposing (..)

import Json.Decode as D
import PSN


type alias Model =
    { state : String
    , error : String
    , wishlistItems : List PSN.WishlistItem
    }


emptyModel =
    Model "" "" []


type Message
    = DownloadCSV
    | GotPSNWishlistItems (List PSN.WishlistItem)
    | PSNWishlistScriptError String
    | PSNWishlistParseError D.Error
    | ScriptResultParseError D.Error
    | UnknownScriptResult String
