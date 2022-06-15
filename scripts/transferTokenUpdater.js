const Token = artifacts.require("Token");
const state = require("../state_bmainnet.json");

const newUpdater = "0xD3582f616059044c6289155433940b564bCB6476";

module.exports = async function(callback) {
    const token = await Token.at(state.Token.address);
    const [account] = await web3.eth.getAccounts();

    await token.addUpdater(newUpdater);
    if (await token.isUpdater(newUpdater)) console.log(`${newUpdater} granted updater rights`);
    else throw new Error("addUpdater call did not work properly");

    await token.renounceUpdater();
    if (!(await token.isUpdater(account))) console.log(`${account} updater rights renounced`);
    else throw new Error("renounceUpdater call did not work properly");

    callback();
};
