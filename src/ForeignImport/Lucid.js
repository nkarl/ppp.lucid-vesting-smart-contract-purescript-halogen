import * as L from 'lucid-cardano';
import * as Dotenv from 'dotenv';

Dotenv.config({
    path: process.cwd() + "./.env"
});

const blockfrost = {
    url: "https://cardano-preview.blockfrost.io/api/v0",
    id: process.env.BLOCKFROST_PROJECT_ID
}

function createProviderImpl(_) {
    return function() {
        return new L.Blockfrost(blockfrost.url, blockfrost.id);
    }
}

function createPromiseLucidImpl(_) {
    var provider = new L.Blockfrost(blockfrost.url, blockfrost.id);
    var api = (async () => await window.cardano.nami.enable())();
    const lucid = (async () => await L.Lucid.new(provider, "Preview"))
        ().then(a => a.selectWallet(api));
    return async function() {
        return lucid;
    }
}

export {
    createProviderImpl,
    createPromiseLucidImpl
}
