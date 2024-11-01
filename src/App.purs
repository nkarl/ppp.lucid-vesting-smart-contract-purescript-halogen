module Components.App where

import Prelude

import Halogen.HTML as HH

import Components.HTML.Utils (className)
import Components.ContractActions as ContractActions
import Components.ContractTxTable as ContractTxTable

import Components.WalletInfo as WalletInfo

render :: forall t w i. t -> HH.HTML w i
render _ =
  HH.div
    [ className "container-fluid d-flex flex-column" ]
    [ HH.div [ className "row" ]
        [ HH.div [ className "col" ]
            [ WalletInfo.render unit
            ]
        ]
    , HH.div [ className "row" ]
        [ HH.div [ className "col-4" ]
            [ ContractActions.render unit
            ]
        , HH.div [ className "col-8" ]
            [ ContractTxTable.render unit
            ]
        ]
    ]
