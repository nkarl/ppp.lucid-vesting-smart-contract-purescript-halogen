export function hasCardanoImpl(window) {
  return function() {
    return window.cardano;
  }
}

export function hasNamiImpl(cardano) {
  return function() {
    return cardano.nami;
  }
}

//export function enableImpl(window) {
//var enable = window.cardano.nami.enable;
//return function() {
//return enable();
//}
//}

//export function isEnabledImpl(window) {
//var isEnabled = window.cardano.nami.isEnabled;
//return async function() {
//return await isEnabled();
//}
//}
