module Main where

import Prelude

import Components.App as App
import Data.String (Pattern(..), contains)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (logShow)
import ForeignImport.Wallet as WalletFFI
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Web.HTML (window)
import Web.HTML.Navigator (userAgent)
import Web.HTML.Window (alert, navigator)

import Utils as Utils

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
  -- NOTE: browser agent guard
  agent <- userAgent =<< navigator =<< window
  logShow agent
  if (Pattern "Chrome") `contains` agent then do
    HA.runHalogenAff do
      body <- HA.awaitBody
      runUI component unit body
  else
    alert "The App only supports Chromium-based browser." =<< window
  -- NOTE: end browser agent guard

  viewEffectWalletFFI

viewEffectWalletFFI :: Effect Unit
viewEffectWalletFFI = launchAff_ do
  w <- liftEffect $
    window >>= Utils.myLog "spy content `window`"
  cardano <- liftEffect $
    WalletFFI.hasCardanoImpl w >>= Utils.myLog "spy content `window.cardano`"
  _ <- liftEffect $
    WalletFFI.hasNamiImpl cardano >>= Utils.myLog "spy content `window.cardano.nami`"
  pure unit
