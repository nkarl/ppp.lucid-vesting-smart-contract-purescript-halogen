This is a PureScript rewrite of the vesting smart contract application that is a use case demo in Week 03 of the [Plutus Pioneer Program](https://iog-academy.gitbook.io/plutus-pioneers-program-fourth-cohort/) (PPP).

This smart contract demonstrate how to connect the following components into a simple application:

1. a 3rd-party API that provides wallet integration ([Lucid](https://lucid.spacebudz.io/) via a chromimum-based extension).
2. a simple application UI based on the PureScript + Nix stack, and Bootstrap for simple styling.


### Aim

This rewrite's largest aim is to translate a simple JS/TS app to a fully functional language a la PureScript (Haskell-family). Instead of using JavaScript/HTML/CSS, this app is built using Halogen (a component-based web development framework) and deployed with Spago. The functional programming paradigm is different from the procedure style in very fundamental way. This app serves as a good practice for translation.

This rewrite also aims to reinforce my mental model for a vesting smart contract. This will be a good reference for future smart contract use cases.

### Run It

```sh
nix develop && pnpm install && pnpm run serve
```

MIT License
