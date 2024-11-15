module ForeignImport.Lucid where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Promise (Promise)
import Promise.Aff as PromiseAff
import Web.HTML (Window)

type Provider = {url :: String, id :: String}

foreign import createProviderImpl
  :: Provider -> Effect Type

createProvider :: Provider -> Effect Type
createProvider = createProviderImpl

foreign import createPromiseLucidImpl
  :: Window -> Effect (Promise Type)

createPromiseLucid :: Window -> Aff Type
createPromiseLucid = createPromiseLucidImpl >>> PromiseAff.toAffE

-- TODO: Implement foreign import for Lucid's member functions.

foreign import data Lucid :: Type

foreign import validatorToAddressImpl
  :: Lucid -> Type -> String

foreign import utxosAtImpl
  :: Lucid -> String -> Array Type
