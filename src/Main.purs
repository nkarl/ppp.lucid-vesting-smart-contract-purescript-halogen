module Main where

import Prelude

import Data.String (Pattern(..), contains)
import Effect (Effect)
import Effect.Class.Console (logShow)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)
import Web.HTML (window)
import Web.HTML.Navigator (userAgent)
import Web.HTML.Window (alert, navigator)

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState: identity
    , render: render
    , eval: H.mkEval H.defaultEval
    }
  where

  render _ =
    HH.div
      [ HP.class_ $ HH.ClassName "container-fluid d-flex flex-column" ]
      [ HH.h1_
          [ HH.text "Hello World!"
          ]
      ]

main :: Effect Unit
main = do
  a <- userAgent =<< navigator =<< window
  logShow a
  if (Pattern "Chrome") `contains` a then do
    HA.runHalogenAff do
      body <- HA.awaitBody
      runUI component unit body
  else
    alert "The App only support Chromium-based browser." =<< window
