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
import ForeignImport.Wallet as WalletFFI
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
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
  render _ = App.render unit

main :: Effect Unit
main = do
  -- NOTE browser agent guard
  agent <- userAgent =<< navigator =<< window
  logShow agent
  if (Pattern "Chrome") `contains` agent then
    HA.runHalogenAff $ runUI component unit =<< HA.awaitBody
  else
    alert "The App only supports Chromium-based browser." =<< window
  -- NOTE end browser agent guard

  launchAff_ $ liftEffect $ viewEffectsWindow
  launchAff_ $ liftEffect $ viewEffectsWallet
  launchAff_ $ liftEffect $ viewEffectsNami
  launchAff_ $ liftEffect $ viewEffectsProp
  launchAff_ $ performEffectsNamiFromWindow
  launchAff_ $ performEffectsNamiFromNami

viewEffectsWindow :: Effect Unit
viewEffectsWindow =
  void $ Utils.myLog "spy content of `window`" =<< window

viewEffectsWallet :: Effect Unit
viewEffectsWallet =
  void $ (WalletFFI.hasCardanoImpl =<< window) >>= Utils.myLog "spy content of Cardano chain `window.cardano`"

viewEffectsNami :: Effect Unit
viewEffectsNami = do
  nami <- (WalletFFI.maybeNami =<< window)
  -- NOTE parse and view Nami node
  void $ Utils.myLog "spy content of wallet API `window.cardano.nami`" nami
  -- NOTE parse and view Nami node with Maybe handling
  void $ case nami of
    Nothing -> pure unit
    Just x -> void $ Utils.myLog "spy content of wallet API with Maybe handling `Just Nami`" x

performEffectsNamiFromWindow :: Aff Unit
performEffectsNamiFromWindow  = do
  w <- liftEffect window
  void $ WalletFFI.isEnabledNami w >>= Utils.myLog "spy content of promise `nami.isEnabled` (from `window`)"

performEffectsNamiFromNami :: Aff Unit
performEffectsNamiFromNami = do
  nami <- liftEffect $ WalletFFI.hasNamiImpl =<< window
  void $ WalletFFI.isEnabledNami2 nami >>= Utils.myLog "spy content of promise `nami.isEnabled` from (`window.cardano.nami`)"

viewEffectsProp :: Effect Unit
viewEffectsProp = do
  w <- window
  -- NOTE parse and view some Prop 
  void $ WalletFFI.hasPropImpl w >>= Utils.myLog "spy content `window.prop`"
  -- NOTE parse and view some Prop with Maybe handling
  prop <- WalletFFI.maybeProp w
  void $ case prop of
    Nothing -> logShow "this code path is supposed to show nothing."
    Just x' -> void $ Utils.myLog "spy content of `Just Prop`" x'
