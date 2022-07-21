import fs from 'fs';
import Truffle from 'truffle';
import state from "../state";
import ADDRESSES from '../addresses';

export default async ({ artifacts }: { artifacts: Truffle.Artifacts },
  deployer, network, accounts): Promise<void> => {

    const [default_, admin] = accounts;
    const addresses = ADDRESSES[network];
    const networkState = await readState(network);

    const c_BasketManager = artifacts.require("BasketManager");

    const d_BasketManager = await state.conditionalDeploy(c_BasketManager, 'BasketManager',
        () => c_BasketManager.new(addresses.bassets, addresses.factors, addresses.bridges));

    console.log(`Deployed BasketManager at ${d_BasketManager.address}`);

    const c_Masset = artifacts.require("Masset");
    const d_Masset = await c_Masset.at(networkState.Masset.address);

    await d_Masset.setBasketManager(d_BasketManager.address);

    return;
  }

  async function readState(network): Promise<any> {
    return new Promise<any>((resolve, reject) => {
        fs.readFile(`state_${network}.json`, (err, data) => {
            if (err) return reject(err);
            resolve(JSON.parse(data.toString('utf-8')));
        });
    });
}