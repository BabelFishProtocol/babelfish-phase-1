/* eslint-disable @typescript-eslint/explicit-function-return-type */
/* eslint-disable @typescript-eslint/no-use-before-define */
import { expectRevert, expectEvent } from "@openzeppelin/test-helpers";
import { BN, tokens } from "@utils/tools";
import envSetup from "@utils/env_setup";
import { ZERO_ADDRESS, FEE_PRECISION, ZERO } from "@utils/constants";
import { StandardAccounts } from "@utils/standardAccounts";
import { Fees } from "types";
import { BasketManagerV4Instance, MassetV4Instance, MockBridgeInstance, MockERC20Instance, TokenInstance, FeesVaultInstance } from "types/generated";

const { expect } = envSetup.configure();

const BasketManagerV4 = artifacts.require("BasketManagerV4");
const MassetV4 = artifacts.require("MassetV4");
const Token = artifacts.require("Token");
const MockERC20 = artifacts.require("MockERC20");
const MockBridge = artifacts.require("MockBridge");
const FeesVault = artifacts.require("FeesVault");

let standardAccounts: StandardAccounts;

const standardFees: Fees = {
    deposit: new BN(100),
    depositBridge: new BN(200),
    withdrawal: new BN(300),
    withdrawalBridge: new BN(400)
};

contract("MassetV4", async (accounts) => {
    let masset: MassetV4Instance;
    let basketManagerObj: BasketManagerObj;
    let token: TokenInstance;
    let vault: FeesVaultInstance;
    let mockTokenDummy: MockERC20Instance;
    let mockBridge: MockBridgeInstance;

    standardAccounts = new StandardAccounts(accounts);

    before("before all", async () => { });

    describe("initialize", async () => {

        beforeEach(async () => {
            masset = await MassetV4.new();
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
            token = await createToken(masset);
        });

        context("should succeed", async () => {
            it("when given a valid basket manager", async () => {
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false
                );

                let version = await masset.getVersion();
                expect(version).to.eq("4.0");

                const setToken = await masset.getToken();
                expect(setToken).to.eq(token.address);

                const setBasketManager = await masset.getBasketManager();
                expect(setBasketManager).to.eq(basketManagerObj.basketManager.address);
            });
        });
        context("should fail", async () => {
            it("when basket manager missing", async () => {
                await expectRevert(
                    masset.initialize(ZERO_ADDRESS, token.address, false),
                    "VM Exception while processing transaction: reverted with reason string 'invalid basket manager'",
                );
            });
            it("when token missing", async () => {
                await expectRevert(
                    masset.initialize(
                        basketManagerObj.basketManager.address,
                        ZERO_ADDRESS,
                        false
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'invalid token'",
                );
            });
            it("when already initialized", async () => {
                await masset.initialize(
                    basketManagerObj.basketManager.address,
                    token.address,
                    false
                );
                await expectRevert(
                    masset.initialize(
                        basketManagerObj.basketManager.address,
                        token.address,
                        false
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'already initialized'",
                );
            });
        });
    });

    describe("mint", async () => {
        beforeEach(async () => {
            masset = await MassetV4.new();
            vault = await FeesVault.new();
            token = await createToken(masset);
            basketManagerObj = await createBasketManager(masset, [18, 18], [100, 1]);
            await initMassetV4(
                masset,
                basketManagerObj.basketManager.address,
                token.address
            );

            mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);
        });

        context("should succeed", () => {
            it("if all params are valid", async () => {
                const sum = tokens(1024);
                const massetQuantity = sum.div(new BN(100));

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                const tx = await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });

                await expectEvent(tx.receipt, "Minted", {
                    minter: standardAccounts.dummy1,
                    recipient: standardAccounts.dummy1,
                    massetQuantity: massetQuantity,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: sum,
                });

                const balance = await token.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.eq(massetQuantity);
            });

            it("if all params are valid, amounts that don't divide evenly", async () => {
                const factor = new BN(1000);
                await basketManagerObj.basketManager.setFactor(basketManagerObj.mockToken1.address, factor);

                const sum = new BN(1024);

                const expectedReminder = sum.mod(factor);
                const bassetsLeft = sum.sub(expectedReminder);
                const massetsToMint = sum.sub(expectedReminder).div(factor);

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });
                const tx = await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });

                await expectEvent(tx.receipt, "Minted", {
                    minter: standardAccounts.dummy1,
                    recipient: standardAccounts.dummy1,
                    massetQuantity: massetsToMint,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: bassetsLeft,
                });

                const balance = await token.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.eq(massetsToMint);
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
                    "VM Exception while processing transaction: reverted with reason string 'SafeERC20: low-level call failed'",
                );
            });
        });
    });
    describe("mintTo", async () => {
        beforeEach(async () => {
            vault = await FeesVault.new();
            masset = await MassetV4.new();
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
            token = await createToken(masset);

            await initMassetV4(
                masset,
                basketManagerObj.basketManager.address,
                token.address
            );
        });
        context("should succeed", () => {
            it("if all params are valid", async () => {
                const sum = tokens(1);
                const expectedMassetQuantity = sum;

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
                    massetQuantity: expectedMassetQuantity,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: sum,
                });
                const balance = await token.balanceOf(standardAccounts.dummy4);
                expect(balance).bignumber.to.eq(expectedMassetQuantity);
            });
        });
    });

    describe("redeem", async () => {
        beforeEach(async () => {
            vault = await FeesVault.new();
            masset = await MassetV4.new();
            token = await createToken(masset);
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);

            await initMassetV4(
                masset,
                basketManagerObj.basketManager.address,
                token.address
            );

            mockTokenDummy = await MockERC20.new("", "", 12, standardAccounts.dummy1, 1);
        });

        context("should succeed", () => {
            it("if all params are valid", async () => {
                const initialBalance = await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1);
                const sum = new BN(123123).pow(new BN(2));

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });

                await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });

                const calculated = await basketManagerObj.basketManager.convertBassetToMassetQuantity(basketManagerObj.mockToken1.address, sum);
                let mintedMassets = calculated[0];

                let balance = await token.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.equal(mintedMassets);

                balance = await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.equal(initialBalance.sub(sum));

                await token.approve(masset.address, mintedMassets, {
                    from: standardAccounts.dummy1,
                });

                const tx = await masset.redeem(basketManagerObj.mockToken1.address, mintedMassets, {
                    from: standardAccounts.dummy1,
                });
                await expectEvent(tx.receipt, "Redeemed", {
                    redeemer: standardAccounts.dummy1,
                    recipient: standardAccounts.dummy1,
                    massetQuantity: mintedMassets,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: mintedMassets,
                });

                balance = await token.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.equal(tokens(0));

                balance = await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.equal(initialBalance);
            });

            it("if all params are valid, amounts that don't divide evenly", async () => {
                const factor = new BN(-10);
                await basketManagerObj.basketManager.setFactor(basketManagerObj.mockToken1.address, factor);

                const initialBalance = await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1);
                const sum = new BN(123123);
                const bassetsLeft = sum;
                const massetsToMint = sum.mul(factor.abs());

                await basketManagerObj.mockToken1.approve(masset.address, sum, {
                    from: standardAccounts.dummy1,
                });

                await masset.mint(basketManagerObj.mockToken1.address, sum, {
                    from: standardAccounts.dummy1,
                });

                const calculated = await basketManagerObj.basketManager.convertBassetToMassetQuantity(basketManagerObj.mockToken1.address, sum);
                let mintedMassets = calculated[0];

                let balance = await token.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.equal(mintedMassets);

                balance = await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.equal(initialBalance.sub(bassetsLeft));

                await token.approve(masset.address, mintedMassets, {
                    from: standardAccounts.dummy1,
                });

                const tx = await masset.redeem(basketManagerObj.mockToken1.address, mintedMassets, {
                    from: standardAccounts.dummy1,
                });
                await expectEvent(tx.receipt, "Redeemed", {
                    redeemer: standardAccounts.dummy1,
                    recipient: standardAccounts.dummy1,
                    massetQuantity: mintedMassets,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: mintedMassets,
                });

                balance = await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1);
                expect(balance).bignumber.to.equal(initialBalance.sub(sum.sub(mintedMassets)));
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
                await basketManagerObj.mockToken1.approve(masset.address, 100, { from: standardAccounts.dummy1 });
                await masset.mint(basketManagerObj.mockToken1.address, 100, { from: standardAccounts.dummy1 });

                await token.approve(masset.address, 100, { from: standardAccounts.dummy1 });

                await expectRevert(
                    masset.redeem(basketManagerObj.mockToken1.address, 1000, { from: standardAccounts.dummy1 }),
                    "VM Exception while processing transaction: reverted with reason string 'basset balance is not sufficient'"
                );
            });
            it("if amount is greater than balance", async () => {
                const sum = 100;
                await basketManagerObj.mockToken1.approve(masset.address, sum, { from: standardAccounts.dummy1 });
                await masset.mint(basketManagerObj.mockToken1.address, sum, { from: standardAccounts.dummy1 });

                await token.approve(masset.address, sum, { from: standardAccounts.dummy1 });

                await expectRevert( // should revert because fee from minting was taken
                    masset.redeem(basketManagerObj.mockToken1.address, sum, { from: standardAccounts.dummy1 }),
                    "VM Exception while processing transaction: reverted with reason string 'ERC20: burn amount exceeds balance'"
                );
            });
        });
    });

    describe("redeemTo", async () => {
        beforeEach(async () => {
            masset = await MassetV4.new();
            token = await createToken(masset);
            basketManagerObj = await createBasketManager(masset, [18, 18], [1, 1]);
            await initMassetV4(masset, basketManagerObj.basketManager.address, token.address);
        });

        context("should fail", () => {
            it("when recipient is not valid", async () => {
                await expectRevert(
                    masset.redeemTo(basketManagerObj.mockToken1.address, tokens(10), ZERO_ADDRESS, { from: standardAccounts.dummy1 }),
                    "VM Exception while processing transaction: reverted with reason string 'must be a valid recipient'"
                );
            });
        });

        context("should succeed", () => {
            it("if all params are valid", async () => {
                const sum = new BN(10).pow(new BN(3));
                const withdrawAmount = sum;
                const recipient = standardAccounts.dummy2;

                await basketManagerObj.mockToken1.approve(masset.address, sum, { from: standardAccounts.dummy1 });
                await masset.mint(basketManagerObj.mockToken1.address, sum, { from: standardAccounts.dummy1 });

                await token.approve(masset.address, withdrawAmount, { from: standardAccounts.dummy1 });

                await masset.redeemTo(basketManagerObj.mockToken1.address, withdrawAmount, recipient, { from: standardAccounts.dummy1 });

                const tokenBalance = await token.balanceOf(standardAccounts.dummy1);
                expect(tokenBalance).bignumber.to.eq("0");

                const balance = await basketManagerObj.mockToken1.balanceOf(recipient);
                expect(balance).bignumber.to.equal(withdrawAmount, "should transfer bassets to correct recipient");
            });
        });
    });

    describe("redeemToBridge", async () => {
        const mintAmount = tokens(1);
        const mintFee = mintAmount.mul(standardFees.deposit).div(FEE_PRECISION);
        const mintedMassets = mintAmount.sub(mintFee);

        beforeEach(async () => {
            vault = await FeesVault.new();
            masset = await MassetV4.new();
            token = await createToken(masset);
            mockBridge = await MockBridge.new();

            basketManagerObj = await createBasketManager(
                masset,
                [18, 18],
                [1, 1],
                [mockBridge.address, mockBridge.address]
            );

            await initMassetV4(masset, basketManagerObj.basketManager.address, token.address, { from: standardAccounts.default });

            await basketManagerObj.mockToken1.approve(masset.address, mintAmount, { from: standardAccounts.dummy1 });
            await masset.mint(basketManagerObj.mockToken1.address, mintAmount, { from: standardAccounts.dummy1 });
            await token.approve(masset.address, mintAmount, { from: standardAccounts.dummy1 });
        });

        context("should fail", () => {
            it("when bridge is not valid", async () => {
                await basketManagerObj.basketManager.setBridge(
                    basketManagerObj.mockToken1.address,
                    ZERO_ADDRESS,
                    { from: standardAccounts.default }
                );

                await expectRevert(
                    masset.methods["redeemToBridge(address,uint256,address)"](
                        basketManagerObj.mockToken1.address,
                        mintedMassets,
                        standardAccounts.dummy2,
                        { from: standardAccounts.dummy1 }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'invalid bridge'"
                );
            });
        });

        context("should succeed", () => {
            it("if all params are valid", async () => {
                const withdrawalFee = mintedMassets.mul(standardFees.withdrawalBridge).div(FEE_PRECISION);

                await masset.methods["redeemToBridge(address,uint256,address)"](
                    basketManagerObj.mockToken1.address,
                    mintedMassets,
                    standardAccounts.dummy2,
                    { from: standardAccounts.dummy1 }
                );

                const bridgeBalance = await getBalance(basketManagerObj.mockToken1, mockBridge.address);
                expect(bridgeBalance).to.bignumber.eq(mintedMassets.sub(withdrawalFee), "should transfer bassets to bridge");

                const vaultBalance = await token.balanceOf(vault.address);
                expect(vaultBalance).bignumber.to.eq(mintFee.add(withdrawalFee));
            });
        });
    });

    describe("onTokensMinted", async () => {
        beforeEach(async () => {
            vault = await FeesVault.new();
            masset = await MassetV4.new();
            token = await createToken(masset);
            mockBridge = await MockBridge.new();

            basketManagerObj = await createBasketManager(
                masset,
                [18, 18],
                [1, 1],
                [mockBridge.address, mockBridge.address]
            );

            await initMassetV4(
                masset,
                basketManagerObj.basketManager.address,
                token.address
            );
        });

        context("should fail", async () => {
            it("when it's not called by bridge", async () => {
                await expectRevert(
                    masset.onTokensMinted(
                        tokens(1),
                        basketManagerObj.mockToken1.address,
                        web3.eth.abi.encodeParameters(['bytes'], [standardAccounts.dummy1]),
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'only bridge may call'"
                );
            });

            it("when recipient address is invalid", async () => {
                await expectRevert(
                    mockBridge.callOnTokensMinted(
                        masset.address,
                        tokens(1),
                        basketManagerObj.mockToken1.address,
                        ZERO_ADDRESS,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'Converter: Error decoding extraData'"
                );
            });

            it("when amount is zero", async () => {
                await expectRevert(
                    mockBridge.callOnTokensMinted(
                        masset.address,
                        tokens(0),
                        basketManagerObj.mockToken1.address,
                        standardAccounts.dummy1,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'amount must be > 0'"
                );
            });

            it("when basset is invalid", async () => {
                await expectRevert(
                    mockBridge.callOnTokensMinted(
                        masset.address,
                        tokens(1),
                        standardAccounts.other,
                        standardAccounts.dummy1,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'invalid basset'"
                );
            });


            it("when basket is out of balance", async () => {
                await basketManagerObj.basketManager.setRange(basketManagerObj.mockToken1.address, 0, 10, { from: standardAccounts.default });

                await expectRevert(
                    mockBridge.callOnTokensMinted(
                        masset.address,
                        tokens(10000),
                        basketManagerObj.mockToken1.address,
                        standardAccounts.dummy1,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'basket out of balance'"
                );
            });
        });

        context("should succeed", async () => {
            it("whit all valid params", async () => {
                const amount = tokens(1);
                const expectedFee = amount.mul(standardFees.depositBridge).div(FEE_PRECISION);
                const expectedMassetQuantity = amount.sub(expectedFee);

                const recipient = standardAccounts.dummy1;

                const recepit = await mockBridge.callOnTokensMinted(
                    masset.address,
                    amount,
                    basketManagerObj.mockToken1.address,
                    recipient,
                    { from: standardAccounts.default }
                );

                await expectEvent.inTransaction(recepit.tx, MassetV4, "Minted", {
                    minter: mockBridge.address,
                    recipient,
                    massetQuantity: expectedMassetQuantity,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: amount,
                }, {});

                const balance = await token.balanceOf(recipient);
                expect(balance).bignumber.to.eq(expectedMassetQuantity, "should mint proper amount of tokens to recipient");

                const vaultBalance = await token.balanceOf(vault.address);
                expect(vaultBalance).bignumber.to.eq(expectedFee, "should mint proper amount of tokens to recipient");
            });
        });
    });

    describe("redeemByBridge", async () => {
        const fees = {
            ...standardFees,
            withdrawalBridge: new BN(0)
        };

        beforeEach(async () => {
            vault = await FeesVault.new();
            masset = await MassetV4.new();
            token = await createToken(masset);
            mockBridge = await MockBridge.new();

            basketManagerObj = await createBasketManager(
                masset,
                [18, 18],
                [1, 1],
                [mockBridge.address, mockBridge.address]
            );

            await initMassetV4(
                masset,
                basketManagerObj.basketManager.address,
                token.address
            );
        });

        context("should fail", async () => {
            it("when it's not called by bridge", async () => {
                await expectRevert(
                    masset.redeemByBridge(
                        basketManagerObj.mockToken1.address,
                        tokens(1),
                        standardAccounts.dummy1,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'must be called by bridge'"
                );
            });

            it("when recipient address is invalid", async () => {
                await expectRevert(
                    mockBridge.callRedeemByBridge(
                        masset.address,
                        basketManagerObj.mockToken1.address,
                        tokens(1),
                        ZERO_ADDRESS,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'must be a valid recipient'"
                );
            });

            it("when amount is zero", async () => {
                await expectRevert(
                    mockBridge.callRedeemByBridge(
                        masset.address,
                        basketManagerObj.mockToken1.address,
                        tokens(0),
                        standardAccounts.dummy1,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'masset quantity must be greater than 0'"
                );
            });

            it("when basset is invalid", async () => {
                await expectRevert(
                    mockBridge.callRedeemByBridge(
                        masset.address,
                        standardAccounts.other,
                        tokens(1),
                        standardAccounts.dummy1,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'invalid basset'"
                );
            });


            it("when basket is out of balance", async () => {
                await basketManagerObj.basketManager.setRange(basketManagerObj.mockToken1.address, 0, 10, { from: standardAccounts.default });

                await expectRevert(
                    mockBridge.callRedeemByBridge(
                        masset.address,
                        basketManagerObj.mockToken1.address,
                        tokens(10000),
                        standardAccounts.dummy1,
                        { from: standardAccounts.default }
                    ),
                    "VM Exception while processing transaction: reverted with reason string 'insufficient balance'"
                );
            });
        });

        context("should succeed", async () => {
            it("whith all valid params", async () => {
                const recipient = standardAccounts.dummy1;
                
                // ----- make a deposit to get some massets -----
                
                const initialToken1Balance = await basketManagerObj.mockToken1.balanceOf(recipient);
                await basketManagerObj.mockToken1.approve(masset.address, initialToken1Balance, {
                    from: recipient,
                });
                await masset.mint(basketManagerObj.mockToken1.address, initialToken1Balance, {
                    from: recipient,
                });

                const expectedMintFee = initialToken1Balance.mul(fees.deposit).div(FEE_PRECISION);

                const bassetBalanceAfterMint = await basketManagerObj.mockToken1.balanceOf(recipient);
                const massetBalanceAfterMint = await token.balanceOf(recipient);

                // ----- withdraw tokens using bridge -----

                const amount = tokens(1);
                const expectedFee = amount.mul(fees.withdrawalBridge).div(FEE_PRECISION);
                const expectedBassetQuantity = amount.sub(expectedFee);

                const recepit = await mockBridge.callRedeemByBridge(
                    masset.address,
                    basketManagerObj.mockToken1.address,
                    amount,
                    recipient,
                    { from: standardAccounts.default }
                );

                await expectEvent.inTransaction(recepit.tx, MassetV4, "Redeemed", {
                    redeemer: recipient,
                    recipient,
                    massetQuantity: amount,
                    bAsset: basketManagerObj.mockToken1.address,
                    bassetQuantity: expectedBassetQuantity
                }, {});

                const massetBalance = await token.balanceOf(recipient);
                expect(massetBalance).bignumber.to.eq(massetBalanceAfterMint.sub(amount), "should take proper amount of tokens from recipient");

                const bassetBalance = await basketManagerObj.mockToken1.balanceOf(recipient);
                expect(bassetBalance).bignumber.to.eq(bassetBalanceAfterMint.add(expectedBassetQuantity), "should give proper amount of bassets to recipient");

                const bridgeMassetBalance = await token.balanceOf(mockBridge.address);
                expect(bridgeMassetBalance).bignumber.to.eq(ZERO, "should not take any massets from bridge");

                const bridgeBassetBalance = await basketManagerObj.mockToken1.balanceOf(mockBridge.address);
                expect(bridgeBassetBalance).bignumber.to.eq(ZERO, "bridge should not get any bassets");

                const vaultBalance = await token.balanceOf(vault.address);
                expect(vaultBalance).bignumber.to.eq(expectedMintFee.add(expectedFee), "should use proper fee (withdrawBridgeFee)");
            });
        });
    });

    describe("precision conversion", async () => {
        const basset1Factor = new BN(100);
        const basset2Factor = new BN(-1000000);

        beforeEach(async () => {
            vault = await FeesVault.new();
            masset = await MassetV4.new();
            token = await createToken(masset);
            basketManagerObj = await createBasketManager(masset, [20, 12], [basset1Factor, basset2Factor]);

            await initMassetV4(
                masset,
                basketManagerObj.basketManager.address,
                token.address
            );
        });
        it("works both ways", async () => {
            const amount = tokens(10000);
            const initialToken1Balance = (await basketManagerObj.mockToken1.balanceOf(standardAccounts.dummy1));
            const initialToken2Balance = (await basketManagerObj.mockToken2.balanceOf(standardAccounts.dummy1));

            await basketManagerObj.mockToken1.approve(masset.address, initialToken1Balance, {
                from: standardAccounts.dummy1,
            });
            await masset.mint(basketManagerObj.mockToken1.address, initialToken1Balance, {
                from: standardAccounts.dummy1,
            });
            await basketManagerObj.mockToken2.approve(masset.address, initialToken2Balance, {
                from: standardAccounts.dummy1,
            });
            await masset.mint(basketManagerObj.mockToken2.address, initialToken2Balance, {
                from: standardAccounts.dummy1,
            });

            const fee = amount.mul(standardFees.deposit).div(FEE_PRECISION);

            const account1BalanceAfterMint = amount.sub(fee).mul(new BN(2));

            expect(await getBalance(token, standardAccounts.dummy1)).bignumber.to.equal(account1BalanceAfterMint);
            expect(await getBalance(basketManagerObj.mockToken1, standardAccounts.dummy1)).bignumber.to.equal(tokens(0));
            expect(await getBalance(basketManagerObj.mockToken2, standardAccounts.dummy1)).bignumber.to.equal(tokens(0));

            await token.transfer(standardAccounts.dummy2, amount, {
                from: standardAccounts.dummy1,
            });
            expect(await getBalance(token, standardAccounts.dummy1)).bignumber.to.equal(account1BalanceAfterMint.sub(amount));

            await token.approve(masset.address, amount, { from: standardAccounts.dummy2 });
            await masset.redeem(basketManagerObj.mockToken2.address, amount, {
                from: standardAccounts.dummy2,
            });
            expect(await getBalance(token, standardAccounts.dummy2)).bignumber.to.equal(tokens(0));

            const withdrawalFee = amount.mul(standardFees.withdrawal).div(FEE_PRECISION);
            const expectedBalance = amount.sub(withdrawalFee).div(basset2Factor.neg());
            expect(await getBalance(basketManagerObj.mockToken2, standardAccounts.dummy2)).bignumber.to.equal(expectedBalance);

            const totalFee = fee.mul(new BN(2)).add(withdrawalFee); // 2 mints and one redeem
            const vaultBalance = await token.balanceOf(vault.address);
            expect(vaultBalance).bignumber.to.eq(totalFee);
        });
    });
});

const zeroBridges = [ZERO_ADDRESS, ZERO_ADDRESS];

async function initMassetV4(
    masset: MassetV4Instance,
    basketManagerAddress: string,
    tokenAddress: string,
    txDetails: Truffle.TransactionDetails = { from: standardAccounts.default }
): Promise<void> {

    await masset.initialize(
        basketManagerAddress,
        tokenAddress,
        false,
        txDetails
    );
}

async function createBasketManager(
    masset: MassetV4Instance,
    decimals: Array<number>,
    factors: Array<number | BN>,
    bridges = zeroBridges
): Promise<BasketManagerObj> {
    const mockToken1 = await MockERC20.new("", "", decimals[0], standardAccounts.dummy1, 10000, { from: standardAccounts.default });
    const mockToken2 = await MockERC20.new("", "", decimals[1], standardAccounts.dummy1, 10000, { from: standardAccounts.default });

    const bassets = [mockToken1.address, mockToken2.address];

    const mins = [0, 0];
    const maxs = [1000, 1000];
    const pauses = [false, false];
    const targetRatios = [0, 0];

    const basketManager = await BasketManagerV4.new({ from: standardAccounts.default });
    await basketManager.initialize(masset.address, { from: standardAccounts.default });
    await basketManager.addBassets(bassets, factors, bridges, mins, maxs, pauses, targetRatios, { from: standardAccounts.default });

    return {
        mockToken1,
        mockToken2,
        bassets,
        basketManager,
    };
}

async function createToken(masset: MassetV4Instance) {
    const token = await Token.new("Mock1", "MK1", 18);
    token.transferOwnership(masset.address);
    return token;
}

async function getBalance(token: TokenInstance | MockERC20Instance, who: string): Promise<BN> {
    return token.balanceOf(who);
}

type BasketManagerObj = {
    mockToken1: MockERC20Instance;
    mockToken2: MockERC20Instance;
    bassets: string[];
    basketManager: BasketManagerV4Instance;
};
