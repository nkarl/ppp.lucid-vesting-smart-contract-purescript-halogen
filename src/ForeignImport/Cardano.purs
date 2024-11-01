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

foreign import enableImpl :: Window -> Effect (Promise Unit)

enable :: Window -> Aff Unit
enable = enableImpl >>> Promise.toAffE

foreign import isEnabledImpl :: Window -> Effect (Promise Boolean)

isEnabled :: Window -> Aff Boolean
isEnabled = isEnabledImpl >>> Promise.toAffE
