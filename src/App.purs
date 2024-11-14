module Components.App where

import Prelude

import Components.ContractActions as ContractActions
import Components.ContractTxTable as ContractTxTable
import Components.HTML.Utils (className)
import Components.WalletInfo as WalletInfo
import Halogen as H
import Halogen.HTML as HH
import Type.Proxy (Proxy(..))

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState: identity
    , render: render
    , eval: H.mkEval $ H.defaultEval
    }

  where

  render _ =
    HH.div
      [ className "container-fluid d-flex flex-column" ]
      [ HH.div [ className "row" ]
          [ HH.div [ className "col" ]
              [ HH.slot_ (Proxy :: Proxy "component") unit WalletInfo.component unit
              ]
          ]
      , HH.div [ className "row" ]
          [ HH.div [ className "col-4" ]
              [ HH.slot_ (Proxy :: Proxy "component") unit ContractActions.component unit
              ]
          , HH.div [ className "col-8" ]
              [ HH.slot_ (Proxy :: Proxy "component") unit ContractTxTable.component unit
              ]
          ]
      ]
