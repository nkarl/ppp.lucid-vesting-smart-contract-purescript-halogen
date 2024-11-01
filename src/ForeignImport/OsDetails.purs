module ForeignImport.OsDetails where

import Effect (Effect)


type OsDetails =
    { screen :: String
    , browser :: String
    , browserversion :: String
    , browsermajorversion :: String
    , mobile :: String
    , os :: String
    , osversion :: String
    , cookies :: String
    , flashversion :: String
    }

--derive instance genericOsDetails :: Generic (OsDetails) _

--instance showOsDetails :: Show OsDetails where
  --show = genericShow

foreign import osDetails :: Effect OsDetails
