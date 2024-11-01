module ForeignImport.Cardano where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Promise (Promise)
import Promise.Aff as Promise
import Web.HTML (Window)

foreign import data Cardano :: Type

foreign import cardano :: Window -> Effect Cardano

foreign import data Nami :: Type

foreign import nami :: Window -> Effect Nami
foreign import namiVersion :: Window -> Effect String

foreign import data NamiEnabled :: Type

--foreign import enableNami :: Window -> Effect 

foreign import isEnabledImpl :: Window -> Effect (Promise NamiEnabled)

isEnabled :: Window -> Aff NamiEnabled
isEnabled = isEnabledImpl >>> Promise.toAffE
