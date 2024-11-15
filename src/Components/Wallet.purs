module Components.Wallet where

import Prelude

import Components.HTML.Utils (className)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Type.Proxy (Proxy(..))

_label = Proxy :: Proxy "walletInfo"

component :: forall q i o m. H.Component q i o m
component = walletInfo

walletInfo :: forall q i o m. H.Component q i o m
walletInfo =
  H.mkComponent
    { initialState: identity
    , render: render
    , eval: H.mkEval $ H.defaultEval
    }
  where

  render _ =
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
                  [ HH.text "as89234dsf0gh1s0sd0f0234kasdfafa" ]
              , HH.td [ className "col-6", HP.id "cardanoBalance" ]
                  [ HH.text "10000" ]
              ]
          ]
      ]
