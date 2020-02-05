module PSN exposing (..)

import Json.Decode as D
import Json.Encode as E
import Parser


type alias WishlistItem =
    { name : String
    , prevPrice : Price
    , currPrice : Price
    }


type Price
    = PriceBadNumber
    | PriceMissing
    | PriceAmount Float


parseFloat : String -> Price
parseFloat str =
    case Parser.run Parser.float str of
        Err err ->
            PriceBadNumber

        Ok res ->
            PriceAmount res


itemPrice : String -> D.Decoder Price
itemPrice fieldName =
    D.field fieldName
        (D.oneOf
            [ D.null PriceMissing
            , D.map
                parseFloat
                D.string
            ]
        )


wishlistItem : D.Decoder WishlistItem
wishlistItem =
    D.map3 WishlistItem
        (D.field "name" D.string)
        (itemPrice "prev_price")
        (itemPrice "curr_price")


wishlistItems : D.Decoder (List WishlistItem)
wishlistItems =
    D.list wishlistItem


wishlistHandleErr ok err =
    case ok of
        Just res ->
            Ok res

        Nothing ->
            case err of
                Just scriptErr ->
                    Err scriptErr

                Nothing ->
                    Err "Missing data for wishlist"


wishlistItemsWithError : D.Decoder (Result String (List WishlistItem))
wishlistItemsWithError =
    D.map2 wishlistHandleErr
        (D.maybe (D.field "ok" wishlistItems))
        (D.maybe (D.field "err" D.string))
