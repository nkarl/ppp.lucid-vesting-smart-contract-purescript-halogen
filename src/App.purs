module Components.App where

import Prelude

import Components.ContractActions as ContractActions
import Components.ContractTxTable as ContractTxTable
import Components.HTML.Utils (className)
import Components.Wallet as Wallet
import Effect (Effect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)

type Slots :: Row Type
type Slots =
  ( walletInfo :: forall q o. H.Slot q o Unit
  , contractActions :: forall q o. H.Slot q o Unit
  , contractTxTable :: forall q o. H.Slot q o Unit
  )

app :: forall q i o m. H.Component q i o m
app =
  H.mkComponent
    { initialState: identity
    , render: render
    , eval: H.mkEval $ H.defaultEval
    }

  where
  render :: forall s a. s -> HH.ComponentHTML a Slots m
  render _ =
    HH.div
      [ className "container-fluid d-flex flex-column" ]
      [ HH.div [ className "row" ]
          [ HH.div [ className "col" ]
              [ HH.slot_ Wallet._label unit Wallet.walletInfo unit
              ]
          ]
      , HH.div [ className "row" ]
          [ HH.div [ className "col-4" ]
              [ HH.slot_ ContractActions._label unit ContractActions.component unit
              ]
          , HH.div [ className "col-8" ]
              [ HH.slot_ ContractTxTable._label unit ContractTxTable.component unit
              ]
          ]
      ]

run :: Effect Unit
run = HA.runHalogenAff $ (runUI app unit) =<< HA.awaitBody
