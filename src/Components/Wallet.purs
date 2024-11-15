module Components.Wallet where

import Prelude

import Components.HTML.Utils (className)
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Type.Proxy (Proxy(..))

_label = Proxy :: Proxy "walletInfo"

component :: forall q o m. H.Component q Input o m
component = walletInfo

data Action = Click | Receive Input

type Input = { pkh :: String, balance :: Int }

type State = { pkh :: String, balance :: Int }

data Output = Clicked

walletInfo :: forall q o m. H.Component q Input o m
walletInfo =
  H.mkComponent
    { initialState: initialState
    , render: render
    , eval: H.mkEval $ H.defaultEval
        { handleAction = handleAction
        , receive = Just <<< Receive
        }
    }
  where
  initialState :: Input -> State
  initialState _ = { pkh: "", balance: 0 }

  render :: State -> H.ComponentHTML Action () m
  render { pkh, balance } =
    HH.table [ className "table table-hover container mt-3" ]
      [ HH.thead_
          [ HH.tr_
              [ HH.th [ className "col-6" ]
                  [ HH.text "PubKeyHash" ]
              , HH.th [ className "col-6" ]
                  [ HH.text "Balance (ADA)" ]
              ]
          ]
      , HH.tbody_
          [ HH.tr_
              [ HH.td [ className "col-6", HP.id "cardanoPKH" ]
                  --[ HH.text "example as89234dsf0gh1s0sd0f0234kasdfafa" ]
                  [ HH.text $ pkh ]
              , HH.td [ className "col-6", HP.id "cardanoBalance" ]
                  --[ HH.text "example 10000" ]
                  [ HH.text $ show balance ]
              ]
          ]
      ]

  handleAction :: Action -> H.HalogenM State Action () o m Unit
  handleAction = case _ of
                     Receive input -> do
                        H.modify_ _ { pkh = input.pkh, balance = input.balance }
                        
                     Click ->
                       pure unit
                       --H.raise Clicked
