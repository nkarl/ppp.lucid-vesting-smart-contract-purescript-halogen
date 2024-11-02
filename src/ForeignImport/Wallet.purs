module ForeignImport.Wallet where

import Prelude

import Control.Monad.List.Trans (fromEffect)
import Data.Function.Uncurried (Fn3, Fn4, runFn3)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Newtype (class Newtype)
import Data.Show (class Show)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Promise (Promise)
import Promise.Aff as Promise
import Web.HTML (Window, window)

foreign import data Cardano :: Type

foreign import hasCardanoImpl :: Window -> Effect Cardano

foreign import data Nami :: Type

foreign import hasNamiImpl :: Cardano -> Effect Nami

foreign import data Prop :: Type

foreign import hasPropImpl :: Window -> Effect Prop

foreign import maybePropImpl
  :: Fn3
       (Window)
       (Prop -> Maybe Prop)
       (Maybe Prop)
       (Maybe Prop)

maybeProp
  :: Window
  -> Effect (Maybe Prop)
maybeProp w = do
  a <- pure $ runFn3 maybePropImpl w Just Nothing
  pure a

-- TODO: implement a generic maybeProp that searches by Proxy

foreign import maybeNamiImpl
  :: Fn3
    (Window)
    (Nami -> Maybe Nami)
    (Maybe Nami)
    (Maybe Nami)

maybeNami :: Window -> Effect (Maybe Nami)
maybeNami w = do
  n <- pure $ runFn3 maybeNamiImpl w Just Nothing
  pure n

--foreign import data NamiEnabled :: Type

--foreign import enableImpl :: Window -> Effect (Promise Unit)

--enable :: Window -> Aff Unit
--enable = enableImpl >>> Promise.toAffE

--foreign import isEnabledImpl :: Window -> Effect (Promise Boolean)

--isEnabled :: Window -> Aff Boolean
--isEnabled = isEnabledImpl >>> Promise.toAffE
