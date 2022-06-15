/* eslint-disable @typescript-eslint/explicit-function-return-type */
/* eslint-disable @typescript-eslint/no-use-before-define */
import { expectRevert, expectEvent, time } from "@openzeppelin/test-helpers";
import * as t from "types/generated";
import { ZERO_ADDRESS } from "@utils/constants";
import { StandardAccounts } from "@utils/standardAccounts";
import envSetup from "@utils/env_setup";
import {
    MassetContract,
    MassetProxyInstance,
    MockERC20Instance,
    ThresholdProxyAdminContract,
    ThresholdProxyAdminInstance,
    MassetInstance,
    BasketManagerInstance,
} from "types/generated";
import Web3 from "web3";
import addresses from "../migrations/addresses";

const { expect } = envSetup.configure();

const ThresholdProxyAdmin = artifacts.require("ThresholdProxyAdmin");
const BasketManager = artifacts.require("BasketManager");
let bridges = [ZERO_ADDRESS, ZERO_ADDRESS];
const Masset = artifacts.require("Masset");
const Token = artifacts.require("Token");
const MockERC20 = artifacts.require("MockERC20");
const MockBridge = artifacts.require("MockBridge");

let standardAccounts;

contract("Masset", async (accounts) => {
    standardAccounts = new StandardAccounts(accounts);

    before("before all", async () => {});

    describe("initialize", async () => {
        let masset;
        let basketManagerObj, token;
        beforeEach(async () => {
            masset = await Masset.new();
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
            token = await createToken(masset);
        });
        context("should succeed", async () => {
            it("when given a valid basket manager", async () => {
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false,
                    ZERO_ADDRESS,
                );
            });
        });
        context("should fail", async () => {
            it("when basket manager missing", async () => {
                await expectRevert(
                    masset.initialize(ZERO_ADDRESS, token.address, false, ZERO_ADDRESS),
                    "VM Exception while processing transaction: reverted with reason string 'invalid basket manager'",
                );
            });
            it("when token missing", async () => {
                await expectRevert(
                    masset.initialize(
                        basketManagerObj.basketManager.address,
                        ZERO_ADDRESS,
                        false,
                        ZERO_ADDRESS,
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'invalid token'",
                );
            });
            it("when already initialized", async () => {
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false,
                    ZERO_ADDRESS,
                );
                await expectRevert(
                    masset.initialize(
                        basketManagerObj.basketManager.address,
                        token.address,
                        false,
                        ZERO_ADDRESS,
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'already initialized'",
                );
            });
        });
    });

    describe("mint", async () => {
        let masset;
        let basketManagerObj, token;
        let mockTokenDummy;
        beforeEach(async () => {
            masset = await Masset.new();
            token = await createToken(masset);
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
            await masset.initialize(
                basketManagerObj.basketManager.address,
                token.address,
                false,
                ZERO_ADDRESS,
            );
            mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);
        });
        context("should succeed", () => {
            it("if all params are valid", async () => {
                const sum = "1000000000000000000";
                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                const tx = await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await expectEvent(tx.receipt, "Minted", {
                    minter: standardAccounts.dummy1,
                    recipient: standardAccounts.dummy1,
                    massetQuantity: sum,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: sum,
                });
                const balance = await token.balanceOf(standardAccounts.dummy1);
                expect(balance.toString()).to.equal(`${sum}`);
            });
        });
        context("should fail", () => {
            it("if basset is invalid", async () => {
                await expectRevert(
                    masset.mint(ZERO_ADDRESS, 10),
                    "VM Exception while processing transaction: reverted with reason string 'invalid basset'",
                );
            });
            it("if basset is not in the basket", async () => {
                await expectRevert(
                    masset.mint(mockTokenDummy.address, 10),
                    "VM Exception while processing transaction: reverted with reason string 'invalid basset'",
                );
            });
            it("if amount is greater than the balance", async () => {
                await expectRevert(
                    masset.mint(basketManagerObj.mockToken1.address, 100000),
                    "VM Exception while processing transaction: reverted with reason string 'ERC20: transfer amount exceeds balance",
                );
            });
        });
    });
    describe("mintTo", async () => {
        let masset;
        let basketManagerObj, token;
        beforeEach(async () => {
            masset = await Masset.new();
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
            token = await createToken(masset);
            await masset.initialize(
                basketManagerObj.basketManager.address,
                token.address,
                false,
                ZERO_ADDRESS,
            );
        });
        context("should succeed", () => {
            it("if all params are valid", async () => {
                const sum = "100000000000000000";
                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                const tx = await masset.mintTo(
                    basketManagerObj.mockToken1.address,
                    sum,
                    standardAccounts.dummy4,
                    { from: standardAccounts.dummy1 },
                );
                await expectEvent(tx.receipt, "Minted", {
                    minter: standardAccounts.dummy1,
                    recipient: standardAccounts.dummy4,
                    massetQuantity: sum,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: sum,
                });
                const balance = await token.balanceOf(standardAccounts.dummy4);
                expect(balance.toString()).to.equal(`${sum}`);
            });
        });
    });

    describe("redeem", async () => {
        let masset;
        let basketManagerObj, token;
        let mockTokenDummy;
        beforeEach(async () => {
            masset = await Masset.new();
            token = await createToken(masset);
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
            await masset.initialize(
                basketManagerObj.basketManager.address,
                token.address,
                false,
                ZERO_ADDRESS,
            );
            mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);
        });
        context("should succeed", () => {
            it("if all params are valid", async () => {
                const sum = "100000000000000000";
                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });
                let balance = await token.balanceOf(standardAccounts.dummy1);
                expect(balance.toString()).to.equal(`${sum}`);
                balance = await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1);
                expect(balance.toString()).to.equal("900000000000000000");
                const tx = await masset.redeem(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await expectEvent(tx.receipt, "Redeemed", {
                    redeemer: standardAccounts.dummy1,
                    recipient: standardAccounts.dummy1,
                    massetQuantity: sum,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: sum,
                });
                balance = await token.balanceOf(standardAccounts.dummy1);
                expect(balance.toString()).to.equal(`0`);
                balance = await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1);
                expect(balance.toString()).to.equal("1000000000000000000"); // original sum
            });
        });
        context("should fail", () => {
            it("if basset is invalid", async () => {
                await expectRevert(
                    masset.redeem(ZERO_ADDRESS, 10),
                    "VM Exception while processing transaction: reverted with reason string 'invalid basset'",
                );
            });
            it("if basset is not in the basket", async () => {
                await expectRevert(
                    masset.redeem(mockTokenDummy.address, 10),
                    "VM Exception while processing transaction: reverted with reason string 'invalid basset'",
                );
            });
            it("if amount is greater than the balance", async () => {
                await expectRevert(
                    masset.redeem(basketManagerObj.mockToken1.address, 100000),
                    "VM Exception while processing transaction: reverted with reason string 'ERC20: transfer amount exceeds balance'",
                );
            });
        });
    });

    describe("precision conversion", async () => {
        let masset;
        let basketManagerObj, token;
        beforeEach(async () => {
            masset = await Masset.new();
            token = await createToken(masset);
            basketManagerObj = await createBasketManager(masset, [20, 12], [100, -1000000]);
            await masset.initialize(
                basketManagerObj.basketManager.address,
                token.address,
                false,
                ZERO_ADDRESS,
            );
        });
        it("works both ways", async () => {
            expect(await getBalance(basketManagerObj.mockToken1, standardAccounts.dummy1)).to.equal(
                "100000000000000000000",
            );
            expect(await getBalance(basketManagerObj.mockToken2, standardAccounts.dummy1)).to.equal(
                "1000000000000",
            );

            await basketManagerObj.mockToken1.approve(masset.address, "100000000000000000000", {
                from: standardAccounts.dummy1,
            });
            await masset.mint(basketManagerObj.mockToken1.address, "100000000000000000000", {
                from: standardAccounts.dummy1,
            });
            await basketManagerObj.mockToken2.approve(masset.address, "1000000000000", {
                from: standardAccounts.dummy1,
            });
            await masset.mint(basketManagerObj.mockToken2.address, "1000000000000", {
                from: standardAccounts.dummy1,
            });

            expect(await getBalance(token, standardAccounts.dummy1)).to.equal(
                "2000000000000000000",
            );
            expect(await getBalance(basketManagerObj.mockToken1, standardAccounts.dummy1)).to.equal(
                "0",
            );
            expect(await getBalance(basketManagerObj.mockToken2, standardAccounts.dummy1)).to.equal(
                "0",
            );

            await token.transfer(standardAccounts.dummy2, "1000000000000000000", {
                from: standardAccounts.dummy1,
            });
            expect(await getBalance(token, standardAccounts.dummy1)).to.equal(
                "1000000000000000000",
            );

            await masset.redeem(basketManagerObj.mockToken2.address, "1000000000000000000", {
                from: standardAccounts.dummy2,
            });
            expect(await getBalance(token, standardAccounts.dummy2)).to.equal("0");
            expect(await getBalance(basketManagerObj.mockToken2, standardAccounts.dummy2)).to.equal(
                "1000000000000",
            );
        });
    });

    describe("redeemToBridge", async () => {
        let masset;
        let basketManagerObj, token;
        let mockTokenDummy;
        const sum = "1000000000000000000";
        context("should fail", () => {
            it("when bridge is not valid", async () => {
                masset = await Masset.new();
                token = await createToken(masset);
                basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false,
                    ZERO_ADDRESS,
                );
                mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await token.approve(masset.address, sum, { from: standardAccounts.dummy1 });

                await expectRevert(
                    masset.methods["redeemToBridge(address,uint256,address,bytes)"](
                        basketManagerObj.mockToken1.address,
                        sum,
                        standardAccounts.dummy2,
                        Buffer.from(""),
                        { from: standardAccounts.dummy1 },
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'invalid bridge'",
                );
            });
        });

        context("should succeed", () => {
            it("if all params are valid", async () => {
                masset = await Masset.new();
                token = await createToken(masset);
                let massetAddr = masset.address;
                let mockBridge1 = await MockBridge.new();
                bridges = [mockBridge1.address, mockBridge1.address];
                basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false,
                    ZERO_ADDRESS,
                );
                mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await token.approve(masset.address, sum, { from: standardAccounts.dummy1 });

                await masset.methods[
                    "redeemToBridge(address,uint256,address,bytes)"
                ](
                    basketManagerObj.mockToken1.address,
                    sum,
                    standardAccounts.dummy2,
                    Buffer.from(""),
                    { from: standardAccounts.dummy1 },
                );

                const bridgeBalance = await getBalance(
                    basketManagerObj.mockToken1,
                    mockBridge1.address,
                );
                expect(bridgeBalance).to.bignumber.eq(sum, "should transfer bassets to bridge");
            });
        });
    });

    describe("redeemToBridgeWithApproval", async () => {
        let masset;
        let basketManagerObj, token;
        let mockTokenDummy;
        const sum = "1000000000000000000";
        context("should fail", () => {
            it("if invoked directly", async () => {
                masset = await Masset.new();
                token = await createToken(masset);
                let massetAddr = masset.address;
                let mockBridge1 = await MockBridge.new();
                bridges = [mockBridge1.address, mockBridge1.address];
                basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false,
                    ZERO_ADDRESS,
                );
                mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await token.approve(masset.address, sum, { from: standardAccounts.dummy1 });

                await expectRevert(
                    masset.redeemToBridgeWithApproval(
                        standardAccounts.dummy1,
                        sum,
                        basketManagerObj.mockToken1.address,
                        standardAccounts.dummy2,
                        Buffer.from(""),
                        { from: standardAccounts.dummy1 },
                    ),
                    "unauthorized",
                );
            });

            it("if pass wrong method in data", async () => {
                masset = await Masset.new();
                token = await createToken(masset);
                let massetAddr = masset.address;
                let mockBridge1 = await MockBridge.new();
                bridges = [mockBridge1.address, mockBridge1.address];
                basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false,
                    ZERO_ADDRESS,
                );
                mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });

                let contract = new web3.eth.Contract(masset.abi, masset.address);
                let data = contract.methods
                    .redeemToBridge(
                        basketManagerObj.mockToken1.address,
                        sum,
                        standardAccounts.dummy2,
                        Buffer.from(""),
                    )
                    .encodeABI();

                await expectRevert(
                    token.approveAndCall(masset.address, sum, data, {
                        from: standardAccounts.dummy1,
                    }),
                    "method is not allowed",
                );
            });
        });

        context("should succeed", () => {
            it("if all params are valid", async () => {
                masset = await Masset.new();
                token = await createToken(masset);
                let massetAddr = masset.address;
                let mockBridge1 = await MockBridge.new();
                bridges = [mockBridge1.address, mockBridge1.address];
                basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false,
                    ZERO_ADDRESS,
                );
                mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });

                let contract = new web3.eth.Contract(masset.abi, masset.address);
                let data = contract.methods
                    .redeemToBridgeWithApproval(
                        standardAccounts.dummy1,
                        sum,
                        basketManagerObj.mockToken1.address,
                        standardAccounts.dummy2,
                        Buffer.from(""),
                    )
                    .encodeABI();

                await token.approveAndCall(masset.address, sum, data, {
                    from: standardAccounts.dummy1,
                });
                const bridgeBalance = await getBalance(
                    basketManagerObj.mockToken1,
                    mockBridge1.address,
                );
                expect(bridgeBalance).to.bignumber.eq(sum, "should transfer bassets to bridge");
            });
        });
    });

    describe("_msgSender", async () => {
        let masset;
        let basketManagerObj, token;
        let data: string;

        beforeEach(async () => {
            masset = await Masset.new();
            token = await createToken(masset);
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
            await masset.initialize(
                basketManagerObj.basketManager.address,
                token.address,
                false,
                standardAccounts.forwarder,
            );

            // Call data for a transfer transaction for `amount` to `receiver`
            data = web3.eth.abi.encodeFunctionCall(
                {
                    name: "setBasketManager",
                    type: "function",
                    inputs: [
                        {
                            internalType: "address",
                            name: "_basketManagerAddress",
                            type: "address",
                        },
                    ],
                },
                [token.address],
            );
        });

        context("should succeed", async () => {
            it("when from address is appended to data and sender is trusted forwarder", async () => {
                // Append the address of `user` so the contract will consider it is the sender
                const dataWithAddress = data + standardAccounts.default.substr(2);

                // Transaction object with `forwarder` as sender
                const rawTransaction = {
                    from: standardAccounts.forwarder,
                    to: masset.address,
                    data: dataWithAddress,
                };

                const initialBasketManager = await masset.getBasketManager();
                if (initialBasketManager === token.address) throw new Error("Test invalidated");

                await web3.eth.sendTransaction(rawTransaction);
                const finalBasketManager = await masset.getBasketManager();

                assert(finalBasketManager === token.address);
            });

            it("when no address appended to data and sender is not trusted forwarder", async () => {
                // Transaction object with `user` as sender
                const rawTransaction = {
                    from: standardAccounts.default,
                    to: masset.address,
                    data,
                };

                const initialBasketManager = await masset.getBasketManager();
                if (initialBasketManager === token.address) throw new Error("Test invalidated");

                await web3.eth.sendTransaction(rawTransaction);
                const finalBasketManager = await masset.getBasketManager();

                assert(finalBasketManager === token.address);
            });
        });

        context("should fail", async () => {
            it("when from address is appended to data and sender is not trusted forwarder", async () => {
                // Append the address of `user` so the contract will consider it is the sender
                const dataWithAddress = data + standardAccounts.default.substr(2);

                // Transaction object with `receiver` as sender
                const rawTransaction = {
                    from: standardAccounts.dummy1,
                    to: masset.address,
                    data: dataWithAddress,
                };
                const initialBasketManager = await masset.getBasketManager();
                if (initialBasketManager === token.address) throw new Error("Test invalidated");

                await expectRevert(
                    web3.eth.sendTransaction(rawTransaction),
                    "InitializableOwnable: caller is not the owner",
                );

                const finalBasketManager = await masset.getBasketManager();

                assert(finalBasketManager === initialBasketManager);
            });
        });
    });
});

async function createBasketManager(
    masset: MassetInstance,
    decimals: Array<number>,
    factors: Array<number>,
): Promise<any> {
    const mockToken1 = await MockERC20.new("", "", decimals[0], standardAccounts.dummy1, 1);
    const mockToken2 = await MockERC20.new("", "", decimals[1], standardAccounts.dummy1, 1);
    const bassets = [mockToken1.address, mockToken2.address];
    const basketManager = await BasketManager.new(bassets, factors, bridges);
    return {
        mockToken1,
        mockToken2,
        bassets,
        basketManager,
    };
}

async function createToken(masset: MassetInstance): Promise<any> {
    // token set to any because of typechain bug where initialize method type is not correctly created
    const token: any = await Token.new();
    await token.initialize("Mock1", "MK1", 18, ZERO_ADDRESS);
    token.transferOwnership(masset.address);
    return token;
}

async function getBalance(token: any, who: string): Promise<string> {
    return (await token.balanceOf(who)).toString(10);
}
