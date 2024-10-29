module Components.TransactTable where

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import Components.HTML.Utils (className)

render :: forall t w i. t -> HH.HTML w i
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
