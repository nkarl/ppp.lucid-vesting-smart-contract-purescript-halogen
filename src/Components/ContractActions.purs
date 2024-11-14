module Components.ContractActions where

import Prelude

import Components.HTML.Utils (className)
import DOM.HTML.Indexed.ButtonType as ButtonType
import DOM.HTML.Indexed.InputType as InputType
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.HTML.Properties.ARIA as HPAria
import Web.HTML.Common (AttrName(..))

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState: identity
    , render: render
    , eval: H.mkEval $ H.defaultEval
    }

  where

  render _ =
    HH.div [ className "accordion", HP.id "actions" ]
      -- Vest Panel
      [ HH.div [ className "accordion-item" ]
          -- Vest Heading
          [ HH.h2 [ className "accordion-header", HP.id "headingVest" ]
              [ HH.button
                  [ className "accordion-button"
                  , HP.type_ ButtonType.ButtonButton
                  , HP.attr (AttrName "data-bs-toggle") "collapse"
                  , HP.attr (AttrName "data-bs-target") "#vest"
                  , HPAria.expanded "true"
                  , HPAria.controls "vest"
                  ]
                  [ HH.text "Vest"
                  ]
              ]
          -- Vesting
          , HH.div
              [ className "accordion-collapse collapse show"
              , HP.id "vest"
              , HPAria.labelledBy "headingVest"
              , HP.attr (AttrName "data-bs-parent") "#actions"
              ]
              [ HH.div [ className "accordion-body" ]
                  [ HH.label [ className "form-label", HP.for "vestStakeholder" ]
                      [ HH.text "Stakeholder"
                      ]
                  , HH.input [ className "form-control form-control-sm", HP.type_ InputType.InputText, HP.id "vestStakeholder" ]
                  , HH.label [ className "form-label", HP.for "vestAmount" ]
                      [ HH.text "Amount (Lovelace)"
                      ]
                  , HH.input [ className "form-control form-control-sm", HP.type_ InputType.InputNumber, HP.id "vestAmount" ]
                  , HH.label [ className "form-label", HP.for "vestDeadline" ]
                      [ HH.text "Deadline"
                      ]
                  , HH.input [ className "form-control form-control-sm", HP.type_ InputType.InputDatetimeLocal, HP.id "vestDeadline" ]
                  , HH.button [ className "btn btn-primary", HP.type_ ButtonType.ButtonButton, HP.id "vestButton" ]
                      [ HH.text "Vest" ]
                  ]
              ]
          ]
      -- Claim Panel
      , HH.div [ className "accordion-item" ]
          -- Claim Heading
          [ HH.h2 [ className "accordion-header", HP.id "headingClaim" ]
              [ HH.button
                  [ className "accordion-button"
                  , HP.type_ ButtonType.ButtonButton
                  , HP.attr (AttrName "data-bs-toggle") "collapse"
                  , HP.attr (AttrName "data-bs-target") "#claim"
                  , HPAria.expanded "false"
                  , HPAria.controls "claim"
                  ]
                  [ HH.text "Claim"
                  ]
              ]
          -- Claiming
          , HH.div
              [ className "accordion-collapse collapse"
              , HP.id "claim"
              , HPAria.labelledBy "headingClaim"
              , HP.attr (AttrName "data-bs-parent") "#actions"
              ]
              [ HH.div [ className "accordion-body" ]
                  [ HH.label [ className "form-label", HP.for "claimReference" ]
                      [ HH.text "Reference"
                      ]
                  , HH.input [ className "form-control form-control-sm", HP.type_ InputType.InputText, HP.id "claimReference" ]
                  , HH.button [ className "btn btn-primary", HP.type_ ButtonType.ButtonButton, HP.id "claimButton" ]
                      [ HH.text "Claim" ]
                  ]
              ]
          ]
      ]
