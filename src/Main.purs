module Main where

import Prelude

import Components.App as App
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), contains)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (logShow)
import ForeignImport.Lucid as Lucid
import ForeignImport.WalletApi as WalletApi
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)
import Type.Proxy (Proxy(..))
import Utils as Utils
import Web.HTML (window)
import Web.HTML.Navigator (userAgent)
import Web.HTML.Window (alert, navigator)

component :: forall q i o m. MonadAff m => H.Component q i o m
component =
  H.mkComponent
    { initialState: identity
    , render: render
    , eval: H.mkEval H.defaultEval
    }
  where
  render _ = HH.slot_ (Proxy :: Proxy "component") unit App.component unit

main :: Effect Unit
main = do
  -- NOTE browser agent guard
  let contains_ = flip contains
  agent <- userAgent =<< navigator =<< window
  logShow agent
  if agent `contains_` (Pattern "Chrome") then
    HA.runHalogenAff $ (runUI component unit) =<< HA.awaitBody
  else
    alert "The App only supports Chromium-based browser." =<< window
  -- NOTE end browser agent guard

  launchAff_ $ liftEffect $ viewEffectsWindow
  launchAff_ $ liftEffect $ viewEffectsWalletApi
  launchAff_ $ liftEffect $ viewEffectsNami
  launchAff_ $ liftEffect $ viewEffectsProp
  launchAff_ $ performEffectsNamiFromWindow
  launchAff_ $ performEffectsNamiFromNami
  launchAff_ $ do
    w <- liftEffect $ window
    void $ Lucid.createPromiseLucid w >>= Utils.myLog "spy content of lucid object"

viewEffectsWindow :: Effect Unit
viewEffectsWindow =
  void $ Utils.myLog "spy content of `window`" =<< window

viewEffectsWalletApi :: Effect Unit
viewEffectsWalletApi =
  void $ (WalletApi.hasCardanoImpl =<< window) >>= Utils.myLog "spy content of Cardano chain `window.cardano`"

viewEffectsNami :: Effect Unit
viewEffectsNami = do
  -- NOTE parse and view Nami node
  nami <- (WalletApi.maybeNami =<< window) >>= Utils.myLog "spy content of wallet API `window.cardano.nami`"
  -- NOTE parse and view Nami node with Maybe handling
  void $ case nami of
    Nothing -> pure unit
    Just x -> void $ Utils.myLog "spy content of wallet API with Maybe handling `Just Nami`" x

performEffectsNamiFromWindow :: Aff Unit
performEffectsNamiFromWindow = do
  w <- liftEffect window
  void $ WalletApi.isEnabledNami w >>= Utils.myLog "spy content of promise `nami.isEnabled` (from `window`)"

performEffectsNamiFromNami :: Aff Unit
performEffectsNamiFromNami = do
  nami <- liftEffect $ WalletApi.hasNamiImpl =<< window
  void $ WalletApi.isEnabledNami2 nami >>= Utils.myLog "spy content of promise `nami.isEnabled` from (`window.cardano.nami`)"

viewEffectsProp :: Effect Unit
viewEffectsProp = do
  w <- window
  -- NOTE parse and view some Prop 
  void $ WalletApi.hasPropImpl w >>= Utils.myLog "spy content `window.prop`"
  -- NOTE parse and view some Prop with Maybe handling
  prop <- WalletApi.maybeProp w
  void $ case prop of
    Nothing -> logShow "this code path is supposed to show nothing."
    Just x' -> void $ Utils.myLog "spy content of `Just Prop`" x'
