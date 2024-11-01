module Main where

import Prelude

import Components.App as App
import Data.Either (Either(..))
import Data.String (Pattern(..), contains)
import Debug as Debug
import Effect (Effect)
import Effect.Aff (Aff, attempt, delay, error, forkAff, joinFiber, killFiber, launchAff_, makeAff, message)
import Effect.Aff (forkAff, launchAff_, launchAff)
import Effect.Aff.AVar (AVar)
import Effect.Aff.AVar as AVar
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log, logShow)
import ForeignImport.Cardano as Cardano
import ForeignImport.OsDetails as OD
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Web.HTML (window)
import Web.HTML.Navigator (userAgent)
import Web.HTML.Window (alert, navigator)

import Promise.Aff as Promise

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

  runSandbox
  --runSandboxAff
  _ <- launchAff_ do -- check isEnabled
    w <- liftEffect window
    s <- Cardano.isEnabled w
    _ <- pure $ Debug.spy "spy nami async isEnabled" s
    pure unit
  _ <- launchAff_ do -- enable Nami
    w <- liftEffect window
    s <- Cardano.enable w
    _ <- pure $ Debug.spy "spy nami async enable" s
    pure unit
  _ <- launchAff_ do -- check isEnabled again
    w <- liftEffect window
    s <- Cardano.isEnabled w
    _ <- pure $ Debug.spy "spy nami async isEnabled" s
    pure unit
  -- NOTE: the enable function communicates with the wallet extension.
  -- it request for access just once. Therefore, all subsequent checks will return True.

  agent <- userAgent =<< navigator =<< window
  logShow agent
  if (Pattern "Chrome") `contains` agent then do
    HA.runHalogenAff do
      body <- HA.awaitBody
      runUI component unit body
  else
    alert "The App only supports Chromium-based browser." =<< window

runSandboxAff :: Effect Unit
runSandboxAff = launchAff_ do
  w <- liftEffect window
  s <- Cardano.isEnabled w
  _ <- pure $ Debug.spy "spy nami effect" s
  pure unit

runSandbox :: Effect Unit
runSandbox = do
  w <- window
  _ <- pure $ Debug.spy "spy Window:" w
  nami <- Cardano.nami w
  _ <- pure $ Debug.spy "spy nami wallet:" nami
  namiVer <- Cardano.namiVersion w
  _ <- pure $ Debug.spy "spy nami version:" namiVer
  od <- OD.osDetails
  _ <- pure $ Debug.spy "spy OsDetails" (od :: OD.OsDetails)
  logShow od.screen
