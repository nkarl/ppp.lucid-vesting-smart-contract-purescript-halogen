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

{--
  BUG: Currently webpack seems to bundle the entire external libraries together into the dist build.
    This causes a very large payload ~10-15 MB, where the recommended limit is 244 KB.

    My guess is that the large size is because of the 2 depdendencies `lucid-cardano` and `dotenv`. The
    second can be eliminated but not the first.
    
    This is a problem I don't have an immediate solution for yet. Will look into this later.
--}
