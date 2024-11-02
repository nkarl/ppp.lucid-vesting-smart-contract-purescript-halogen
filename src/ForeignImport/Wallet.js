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

export function hasPropImpl(window) {
  return function() {
    return window.prop;
  }
}

export function maybePropImpl(window, just, nothing) {
  if (window.prop) {
    return just(window.prop);
  } else {
    return nothing;
  }
}

export function maybeNamiImpl(window, just, nothing) {
  if (window.cardano.nami) {
    return just(window.cardano.nami);
  } else {
    return nothing;
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
