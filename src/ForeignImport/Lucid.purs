module ForeignImport.Lucid where

import Prelude

import Data.Function.Uncurried (Fn1, runFn1)
import Effect (Effect)
import Effect.Aff (Aff)
import Promise (Promise)
import Promise.Aff as PromiseAff

type Provider = {url :: String, id :: String}

foreign import createProviderImpl
  :: Provider -> Effect Type

createProvider :: Provider -> Effect Type
createProvider = createProviderImpl

foreign import createPromiseLucidImpl
  :: Provider -> Effect (Promise Type)

createPromiseLucid :: Provider -> Aff Type
createPromiseLucid = createPromiseLucidImpl >>> PromiseAff.toAffE
