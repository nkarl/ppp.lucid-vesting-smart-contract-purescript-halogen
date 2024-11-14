function hasCardanoImpl(window) {
  return function() {
    return window.cardano;
  }
}

function hasNamiImpl(window) {
  return function() {
    return window.cardano.nami;
  }
}

function maybeNamiImpl(window, just, nothing) {
  if (window.cardano.nami) {
    return just(window.cardano.nami);
  } else {
    return nothing;
  }
}

function enableNamiImpl(window) {
  var enable = window.cardano.nami.enable;
  return function() {
    return enable();
  }
}

function isEnabledNamiImpl(window) {
  var isEnabled = window.cardano.nami.isEnabled;
  return async function() {
    return await isEnabled();
  }
}

function isEnabledNamiImpl2(nami) {
  var isEnabled = nami.isEnabled;
  return async function() {
    return await isEnabled();
  }
}

function hasPropImpl(window) {
  return function() {
    return window.prop;
  }
}

function maybePropImpl(window, just, nothing) {
  if (window.prop) {
    return just(window.prop);
  } else {
    return nothing;
  }
}

export {
  hasCardanoImpl,
  hasNamiImpl,
  maybeNamiImpl,
  enableNamiImpl,
  isEnabledNamiImpl,
  isEnabledNamiImpl2,
  hasPropImpl,
  maybePropImpl
}
