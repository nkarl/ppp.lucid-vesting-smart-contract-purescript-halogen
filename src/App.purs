module Components.App where

import Prelude

import Components.ContractActions as ContractActions
import Components.ContractTxTable as ContractTxTable
import Components.HTML.Utils (className)
import Components.Wallet as Wallet
import Effect (Effect)
import ForeignImport.Lucid as Lucid
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)
import Utils as Utils
import Web.HTML (window)

{--
  TODO:  design data and actions for the components.
  The App component may track the LucidAPI object as State (which is FFD type).
    1. Wallet component
      - reads `PKH` and `balance` from, which can be sent as Input.
        - may need to be run as an Aff to listen to input from App
    2. ContractActions component
    3. ContractTxTable component
      - reads UTxO array from the address of vesting contract. 
        - may need to be run as an Aff to listen to input from App
--}

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
              [ HH.slot_ Wallet._label unit Wallet.component unit
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

{--
  Only 2 member functions are used for this app:
    1. lucid.utils.validatorToAddress(vestingScript)
    2. lucid.utxosAt(address)
--}

run :: Effect Unit
run = HA.runHalogenAff
  do
    let render = runUI app unit
    -- gets global states from the browser window
    w <- H.liftEffect window
    lucid <- (Lucid.createPromiseLucid) w
    void $ Utils.myLog "spy content of lucid object" lucid
    -- begins rendering this component
    --body <- HA.awaitBody
    render =<< HA.awaitBody
