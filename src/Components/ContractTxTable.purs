module Components.ContractTxTable where

import Prelude

import Components.HTML.Utils (className)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Type.Proxy (Proxy(..))

_label = Proxy :: Proxy "contractTxTable"

component :: forall q i o m. H.Component q i o m
component = contractTxTable

contractTxTable :: forall q i o m. H.Component q i o m
contractTxTable =
  H.mkComponent
    { initialState: identity
    , render: render
    , eval: H.mkEval $ H.defaultEval
    }
  where

  render _ =
    HH.div [ className "accordion", HP.id "actions" ]
      [ HH.div [ className "container-fluid" ]
          [ HH.table [ className "table table-sm table-hover table-bordered", HP.id "utxosTable" ]
              [ HH.caption_ [ HH.text "UTxO's on Cardano" ]
              , HH.thead_
                  [ HH.tr_
                      [ HH.th_ [ HH.text "Ref" ]
                      , HH.th_ [ HH.text "Stakeholder" ]
                      , HH.th_ [ HH.text "ADA" ]
                      , HH.th_ [ HH.text "Deadline" ]
                      ]
                  ]
              , HH.tbody [ HP.id "vestingUTxOsTable" ]
                  []
              ]
          ]
      ]
