import Logs from "node-logs";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { ZERO_ADDRESS } from "@utils/constants";
import { tokens, BN } from "@utils/tools";
import { MassetV3Instance } from "types/generated";
import addresses, { BassetInstanceDetails, hasMultisigAddress, isDevelopmentNetwork } from './utils/addresses';
import { conditionalDeploy, conditionalInitialize, getDeployed, printState } from "./utils/state";
import { DeploymentTags } from "./utils/DeploymentTags";

const ERC20Mintable = artifacts.require("ERC20Mintable");
const BasketManagerV3 = artifacts.require("BasketManagerV3");
const BasketManagerProxy = artifacts.require("BasketManagerProxy");
const MassetV3 = artifacts.require("MassetV3");
const MassetProxy = artifacts.require("MassetProxy");
const FeesVault = artifacts.require("FeesVault");
const FeesVaultProxy = artifacts.require("FeesVaultProxy");
const FeesManager = artifacts.require("FeesManager");
const FeesManagerProxy = artifacts.require("FeesManagerProxy");

const logger = new Logs().showInConsole(true);

const MAX_VALUE = 1000;

const deployFunc = async ({ network, deployments, getUnnamedAccounts }: HardhatRuntimeEnvironment) => {
    logger.info("Starting upgrade to v3 migration");

    const { deploy } = deployments;
    const [default_, _admin] = await getUnnamedAccounts();

    const addressesForNetwork = addresses[network.name];

    const feesVault = await conditionalDeploy({
        contract: FeesVault,
        key: "FeesVault",
        deployfunc: deploy,
        deployOptions: { from: default_ }
    });
    const feesVaultProxy = await conditionalDeploy({
        contract: FeesVaultProxy,
        key: "FeesVaultProxy",
        deployfunc: deploy,
        deployOptions: { from: default_ }
    });

    await conditionalInitialize("FeesVaultProxy",
        async () => { await feesVaultProxy.methods["initialize(address,address,bytes)"](feesVault.address, _admin, "0x"); }
    );
    const vaultFake = await FeesVault.at(feesVaultProxy.address);

    async function upgradeInstance(symbol: string, addressesForInstance: BassetInstanceDetails): Promise<void> {
        const massetFake: MassetV3Instance = await getDeployed(MassetV3, `${symbol}_MassetProxy`);
        const massetVersion = await massetFake.getVersion();

        logger.info(`${symbol}, Masset version: ${massetVersion}`);
        if (massetVersion >= '3.0') {
            logger.warn('Skipping...');
            return;
        }

        const tokenAddress = await massetFake.getToken();

        const basketManager = await conditionalDeploy({
            contract: BasketManagerV3,
            key: `${symbol}_BasketManagerV3`,
            deployfunc: deploy,
            deployOptions: { from: default_ }
        });
        const basketManagerProxy = await conditionalDeploy({
            contract: BasketManagerProxy,
            key: `${symbol}_BasketManagerProxy`,
            deployfunc: deploy,
            deployOptions: { from: default_ }
        });

        const initAbi = basketManager.contract.methods['initialize(address)'](massetFake.address).encodeABI();
        await conditionalInitialize(`${symbol}_BasketManagerProxy`,
            async () => { await basketManagerProxy.methods["initialize(address,address,bytes)"](basketManager.address, _admin, initAbi); }
        );

        const basketManagerFake = await BasketManagerV3.at(basketManagerProxy.address);

        if (isDevelopmentNetwork(network.name)) {
            const basset1 = await ERC20Mintable.new();
            const basset2 = await ERC20Mintable.new();
            const basset3 = await ERC20Mintable.new();

            // set basket balances with perfect ratio
            await basset1.mint(massetFake.address, tokens(30));
            await basset2.mint(massetFake.address, tokens(40));
            await basset3.mint(massetFake.address, tokens(40));

            // mint some tokens for owner
            await basset1.mint(default_, tokens(1000));

            addressesForInstance.bassets = [basset1.address, basset2.address, basset3.address];
            addressesForInstance.factors = [-10, 1, 1];
            addressesForInstance.bridges = [ZERO_ADDRESS, ZERO_ADDRESS, ZERO_ADDRESS];
            addressesForInstance.ratios = [300, 300, 400];
            addressesForInstance.fees = {
                deposit: new BN(5),
                depositBridge: new BN(6),
                withdrawal: new BN(7),
                withdrawalBridge:  new BN(8)
            };
        }

        if (await basketManagerProxy.admin() === _admin) {
            const existingAssets = await basketManagerFake.getBassets();
            const addAsset = async (index: number) => {
                console.log('adding asset: ',
                    addressesForInstance.bassets[index],
                    addressesForInstance.factors[index],
                    addressesForInstance.bridges[index]
                );

                await basketManagerFake.addBasset(
                    addressesForInstance.bassets[index],
                    addressesForInstance.factors[index],
                    addressesForInstance.bridges[index],
                    0,
                    MAX_VALUE,
                    false
                );
            };

            for (let i = 0; i < addressesForInstance.bassets.length; i++) {
                if (!existingAssets.find(ta => ta === addressesForInstance.bassets[i])) {
                    // eslint-disable-next-line no-await-in-loop
                    await addAsset(i);
                }
            }

            if (hasMultisigAddress(addressesForInstance)) {
                if (await basketManagerFake.owner() === default_) {
                    await basketManagerFake.transferOwnership(addressesForInstance.multisig);
                }
                await basketManagerProxy.changeAdmin(addressesForInstance.multisig, { from: _admin });
            }
        }

        const feesManager = await conditionalDeploy({
            contract: FeesManager,
            key: `${symbol}_FeesManager`,
            deployfunc: deploy,
            deployOptions: { from: default_ }
        });
        const feesManagerProxy = await conditionalDeploy({
            contract: FeesManagerProxy,
            key: `${symbol}_FeesManagerProxy`,
            deployfunc: deploy,
            deployOptions: { from: default_ }
        });

        await conditionalInitialize(`${symbol}_FeesManagerProxy`,
            async () => { await feesManagerProxy.methods["initialize(address,address,bytes)"](feesManager.address, _admin, "0x"); }
        );

        const feesManagerFake = await FeesManager.at(feesManagerProxy.address);

        await conditionalInitialize(`${symbol}_FeesManager`, async () => {
            await feesManagerFake.initialize(
                addressesForInstance.fees.deposit,
                addressesForInstance.fees.depositBridge,
                addressesForInstance.fees.withdrawal,
                addressesForInstance.fees.withdrawalBridge
            );
        });

        const masset = await conditionalDeploy({
            contract: MassetV3,
            key: `${symbol}_MassetV3`,
            deployfunc: deploy,
            deployOptions: { from: default_ }
        });

        const massetProxy = await MassetProxy.at(massetFake.address);

        await massetProxy.upgradeTo(masset.address, { from: _admin });
        await massetFake.upgradeToV3(
            basketManagerFake.address,
            tokenAddress,
            vaultFake.address,
            feesManagerFake.address
        );
    }

    await upgradeInstance('ETHs', addressesForNetwork.ETHs);
    await upgradeInstance('XUSD', addressesForNetwork.XUSD);
    await upgradeInstance('BNBs', addressesForNetwork.BNBs);

    logger.success("Migration completed");
    printState();
};

deployFunc.tags = [
    DeploymentTags.V3,
    DeploymentTags.Migration
];

export default deployFunc;
