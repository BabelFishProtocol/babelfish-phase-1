/* eslint-disable @typescript-eslint/camelcase */
/* eslint-disable spaced-comment */
/* eslint-disable @typescript-eslint/triple-slash-reference,spaced-comment */
/// <reference path="../../types/generated/index.d.ts" />
/// <reference path="../../types/generated/types.d.ts" />

import state from "../state";
import ADDRESSES from "../addresses";
import { ZERO_ADDRESS } from "@utils/constants";

class BassetIntegrationDetails {
    bAssets: Array<string>;

    factors: Array<number>;
}

export default async (
    { artifacts }: { artifacts: Truffle.Artifacts },
    deployer,
    network,
    accounts,
): Promise<void> => {
    const c_Token = artifacts.require("Token");
    const c_BasketManager = artifacts.require("BasketManager");
    const c_Masset = artifacts.require("Masset");
    const c_MassetProxy = artifacts.require("MassetProxy");

    //const c_TokenProxy = artifacts.require("TokenProxy");

    const [default_, admin] = accounts;
    const addresses = ADDRESSES[network];

    /*
        To support additional networks, find the forwarder addresses there:
        https://docs.opengsn.org/networks/ethereum/mainnet.html
    */
    let forwarderAddress;
    switch (deployer.network) {
        case "btestnet":
            forwarderAddress = "0xeB230bF62267E94e657b5cbE74bdcea78EB3a5AB";
            break;
        case "bmainnet":
            forwarderAddress = "0xeB230bF62267E94e657b5cbE74bdcea78EB3a5AB";
            break;
        default:
            console.log("Forwarder address not set for network");
    }

    console.log(1);

    const d_Token = await state.conditionalDeploy(c_Token, "Token", () => c_Token.new());

    console.log(2);

    await state.conditionalInitialize("Token", () =>
        d_Token.initialize("BTCs", "BTCs", 18, forwarderAddress),
    );

    console.log(3);

    const paymasterAddress = await d_Token.paymaster();
    if (paymasterAddress !== ZERO_ADDRESS) console.log("Paymaster already set");
    else if (!addresses.paymaster) console.log("No paymaster address provided in config");
    else {
        await d_Token.launchPaymasterUpdate(addresses.paymaster);
        await d_Token.executePaymasterUpdate();
    }

    /*
    const d_TokenProxy = await state.conditionalDeploy(c_TokenProxy, 'TokenProxy',
        () => c_TokenProxy.new());

    const initData1: string = d_Token.contract.methods
        .initialize('XUSD', 'XUSD', 18).encodeABI();
    await state.conditionalInitialize('TokenProxy', () => {
        return d_TokenProxy.methods["initialize(address,address,bytes)"](
            d_Token.address,
            admin,
            initData1,
        );
    });
    */

    console.log(4);

    const d_Masset = await state.conditionalDeploy(c_Masset, "Masset", () =>
        deployer.deploy(c_Masset),
    );

    console.log(5);

    const d_MassetProxy = await state.conditionalDeploy(c_MassetProxy, "MassetProxy", () =>
        deployer.deploy(c_MassetProxy),
    );

    console.log(6);

    const d_BasketManager = await state.conditionalDeploy(c_BasketManager, "BasketManager", () =>
        c_BasketManager.new(addresses.bassets, addresses.factors, addresses.bridges),
    );

    console.log(8);

    await d_Token.transferOwnership(d_MassetProxy.address);

    console.log(9);

    const initData2: string = d_Masset.contract.methods
        .initialize(
            d_BasketManager.address,
            d_Token.address,
            deployer.network !== "development",
            forwarderAddress,
        )
        .encodeABI();
    await state.conditionalInitialize("MassetProxy", () => {
        return d_MassetProxy.methods["initialize(address,address,bytes)"](
            d_Masset.address,
            network == "rsk" || network == "bmainnet" ? addresses.multisig : admin,
            initData2,
        );
    });
    console.log(admin);
    // console.log(10);
    state.printState();
};
