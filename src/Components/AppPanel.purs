module Components.AppPanel where

import Prelude

import Halogen.HTML as HH

import Components.HTML.Utils (className)
import Components.ContractPanel as ContractPanel
import Components.TransactTable as TransactTable

render :: forall t w i. t -> HH.HTML w i
render _ =
  HH.div [ className "row" ]
    [ HH.div [ className "col-4" ]
        [ ContractPanel.render unit
        ]
    , HH.div [ className "col-8" ]
        [ TransactTable.render unit
        ]
    ]
