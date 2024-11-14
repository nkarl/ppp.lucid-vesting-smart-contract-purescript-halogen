module Main where

import Prelude

import Components.App as App
import Data.String (Pattern(..), contains)
import Effect (Effect)
import Web.HTML (window)
import Web.HTML.Navigator (userAgent)
import Web.HTML.Window (alert, navigator)

main :: Effect Unit
main = do
  let contains_ = flip contains
  agent <- userAgent =<< navigator =<< window
  -- NOTE browser agent guard
  if not $ agent `contains_` (Pattern "Chrome") then
    alert "The App only supports Chromium-based browser." =<< window
  -- NOTE end browser agent guard
  else
    App.run
