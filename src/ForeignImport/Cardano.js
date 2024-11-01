export function cardano(window) {
  return function() {
    return window.cardano;
  }
}

export function nami(window) {
  return function() {
    return window.cardano.nami;
  }
}

export function namiVersion(window) {
  return function() {
    return window.cardano.nami.apiVersion;
  }
}

export function enableImpl(window) {
  var enable = window.cardano.nami.enable;
  return function() {
    return enable();
  }
}

export function isEnabledImpl(window) {
  var isEnabled = window.cardano.nami.isEnabled;
  return async function() {
    return await isEnabled();
  }
}
