module Main where

import Prelude

import Components.App as App
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Pattern(..), contains)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Aff.Class (class MonadAff, liftAff)
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

  launchAff_ $ liftEffect $ viewEffectWalletFFI

viewEffectWalletFFI :: Effect Unit
viewEffectWalletFFI = do
  w <- liftEffect $
    window >>= Utils.myLog "spy content `window`"
  cardano <- liftEffect $
    WalletFFI.hasCardanoImpl w >>= Utils.myLog "spy content `window.cardano`"
  _ <- liftEffect $
    WalletFFI.hasNamiImpl cardano >>= Utils.myLog "spy content `window.cardano.nami`"

  -- NOTE parse and view FakeProp
  p <- liftEffect $
    WalletFFI.hasPropImpl w >>= Utils.myLog "spy content `window.prop`"

  -- NOTE parse and view FakeProp with Maybe handling
  someProp <- WalletFFI.maybeProp w
  _ <- case someProp of
    Nothing -> pure unit
    Just x' -> do
      _ <- Utils.myLog "spy content of `Just Prop`" x'
      pure unit
  pure unit

  -- NOTE parse and view Nami with Maybe handling
  nami <- WalletFFI.maybeNami w
  _ <- case nami of
    Nothing -> pure unit
    Just x' -> do
      _ <- Utils.myLog "spy content of `Just Nami`" x'
      pure unit
  pure unit

