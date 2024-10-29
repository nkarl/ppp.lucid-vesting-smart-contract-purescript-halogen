module Components.WalletInfo where

import Prelude

import Components.HTML.Utils (className)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

render :: forall t w i. t -> HH.HTML w i
render _ =
  HH.div [ className "row" ]
    [ HH.div [ className "col" ]
        [ HH.table [ className "table table-hover container mt-3" ]
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
        ]
    ]
