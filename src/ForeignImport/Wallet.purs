module ForeignImport.Wallet where

import Prelude

import Data.Function.Uncurried (Fn3, runFn3)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Promise (Promise)
import Promise.Aff as PromiseAff
import Web.HTML (Window)

foreign import hasCardanoImpl
  :: Window -> Effect Type

foreign import hasNamiImpl
  :: Window -> Effect Type

foreign import maybeNamiImpl
  :: Fn3 (Window) (Type -> Maybe Type) (Maybe Type) (Maybe Type)

maybeNami
  :: Window -> Effect (Maybe Type)
maybeNami w =
  pure $ runFn3 maybeNamiImpl w Just Nothing

foreign import enableNamiImpl
  :: Window -> Effect (Promise Unit)

enableNami
  :: Window -> Aff Unit
enableNami = enableNamiImpl >>> PromiseAff.toAffE

foreign import isEnabledNamiImpl
  :: Window -> Effect (Promise Boolean)

isEnabledNami
  :: Window -> Aff Boolean
isEnabledNami = isEnabledNamiImpl >>> PromiseAff.toAffE

foreign import isEnabledNamiImpl2
  :: Type -> Effect (Promise Boolean)

isEnabledNami2
  :: Type -> Aff Boolean
isEnabledNami2 = isEnabledNamiImpl2 >>> PromiseAff.toAffE

-- TODO: Implement a class of functions for a generic prop (that may or may not exist). Prop shouuld be searched by Proxy.

foreign import hasPropImpl
  :: Window -> Effect Type

foreign import maybePropImpl
  :: Fn3 (Window) (Type -> Maybe Type) (Maybe Type) (Maybe Type)

maybeProp
  :: Window -> Effect (Maybe Type)
maybeProp w = pure $ runFn3 maybePropImpl w Just Nothing

