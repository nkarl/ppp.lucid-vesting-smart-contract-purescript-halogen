module Utils where

import Prelude

import Debug (class DebugWarning)
import Debug as Debug
import Effect.Class (class MonadEffect)

myLog :: forall m a. MonadEffect m => DebugWarning => String -> a -> m a
myLog msg a = do
  _ <- pure $ Debug.spy msg a
  pure a
