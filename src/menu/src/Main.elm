module Main exposing (..)

import Browser
import Dict
import Json.Decode as D
import Json.Encode as E
import Model exposing (..)
import PSN
import Ports.BrowserTab as BrowserTab
import Result
import View exposing (..)


init : {} -> ( Model, Cmd msg )
init flags =
    ( emptyModel
    , BrowserTab.getPSNWishlistItems
    )


handlePsnWishlistError res =
    case res of
        Ok items ->
            GotPSNWishlistItems items

        Err err ->
            PSNWishlistScriptError err


scriptDecoders =
    Dict.fromList
        [ ( "wishlistItems", PSN.wishlistItemsWithError |> D.map handlePsnWishlistError )
        ]


scriptId =
    D.field "id" D.string


decodeScriptResult val =
    case D.decodeValue scriptId val of
        Ok id ->
            case Dict.get id scriptDecoders of
                Just decoder ->
                    case D.decodeValue decoder val of
                        Ok msg ->
                            msg

                        Err err ->
                            PSNWishlistParseError err

                Nothing ->
                    Model.UnknownScriptResult id

        Err err ->
            ScriptResultParseError err


subscriptions model =
    BrowserTab.activeTabScriptResult decodeScriptResult


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        DownloadCSV ->
            ( { model | state = "Downloading CSV" }, Cmd.none )

        GotPSNWishlistItems items ->
            ( { model | state = "Got PSN Wishlist Items", wishlistItems = items |> Debug.log "wishlist Items" }, Cmd.none )

        PSNWishlistScriptError err ->
            ( { model | error = err }, Cmd.none )

        PSNWishlistParseError err ->
            ( { model | error = D.errorToString err }, Cmd.none )

        ScriptResultParseError err ->
            ( { model | error = D.errorToString err }, Cmd.none )

        UnknownScriptResult id ->
            ( { model | error = "Unnknown script result: " ++ id }, Cmd.none )


main =
    Browser.document
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
