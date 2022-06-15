import { expectRevert, expectEvent, time, constants } from "@openzeppelin/test-helpers";
import { toWei } from "web3-utils";
import { TokenInstance } from "types/generated";
import { ZERO_ADDRESS } from "@utils/constants";

const Token = artifacts.require("Token");
const MockToken = artifacts.require("MockToken");
const MockCallReceiver = artifacts.require("MockCallReceiver");

contract("Token", async (accounts) => {
    const [owner, user, user2, receiver, forwarder, paymaster] = accounts;

    // token set to any because of typechain bug where initialize method type is not correctly created
    let token: any;

    beforeEach("before all", async () => {
        token = await Token.new();
        await token.initialize("Test Token", "TT", 18, forwarder);
        await token.mint(user, toWei("100"));
    });

    describe("initialized", () => {
        it("should have set deployer as updater", async () => {
            const result = await token.isUpdater(owner);
            assert(result === true);
        });

        it("should have set trusted forwarder", async () => {
            const result = await token.isTrustedForwarder(forwarder);
            assert(result === true);
        });
    });

    describe("mint", () => {
        context("should succeed", async () => {
            it("when it's called by owner", async () => {
                await token.mint(user, toWei("100"), { from: owner });
            });
        });

        context("should fail", async () => {
            it("when it's not called by owner", async () => {
                await expectRevert(
                    token.mint(user, toWei("100"), { from: user }),
                    "caller is not the owner",
                );
            });
        });
    });

    describe("burn", async () => {
        context("should succeed", async () => {
            it("when it's called by owner", async () => {
                await token.burn(user, toWei("50"), { from: owner });
            });
        });

        context("should fail", async () => {
            it("when it's not called by owner", async () => {
                await expectRevert(
                    token.burn(user, toWei("50"), { from: user }),
                    "caller is not the owner",
                );
            });
        });
    });

    describe("approveAndCall", async () => {
        context("should succeed", async () => {
            it("always", async () => {
                const amount = 10000000;
                const mockCallReceiver = await MockCallReceiver.new();

                await token.approveAndCall(mockCallReceiver.address, amount, "0x");

                const allowance = await token.allowance(owner, mockCallReceiver.address);
                assert(allowance.toNumber() === amount);
            });
        });
    });

    describe("launchPaymasterUpdate", async () => {
        // We need a contract address
        let mockCallReceiver;

        beforeEach(async () => {
            mockCallReceiver = await MockCallReceiver.new();
        });

        context("should succeed", async () => {
            it("when called by updater", async () => {
                const receipt = await token.launchPaymasterUpdate(mockCallReceiver.address);
                const update = await token.paymasterUpdate();

                assert(update[0] === mockCallReceiver.address);
                assert(update[1].toNumber() === 0);
                expectEvent(receipt, "PaymasterUpdateLaunched", {
                    newPaymaster: mockCallReceiver.address,
                });
            });

            it("when not first update", async () => {
                await token.launchPaymasterUpdate(token.address);
                await token.executePaymasterUpdate();

                const timestamp = new Date().getTime() / 1000;

                const receipt = await token.launchPaymasterUpdate(mockCallReceiver.address);
                const update = await token.paymasterUpdate();

                assert(update[0] === mockCallReceiver.address);
                // Substrate 100 to the timestamp to take local chain timestamp discrapency with real timestamp into account
                assert(update[1].toNumber() >= timestamp - 100 + time.duration.weeks(1).toNumber());
                expectEvent(receipt, "PaymasterUpdateLaunched", {
                    newPaymaster: mockCallReceiver.address,
                });
            });
        });

        context("should fail", async () => {
            it("when not updater", async () => {
                await expectRevert(
                    token.launchPaymasterUpdate(user),
                    "address provided is not a contract",
                );
            });

            it("when address is not a contract", async () => {
                await expectRevert(
                    token.launchPaymasterUpdate(user),
                    "address provided is not a contract",
                );
            });

            it("when last update not executed", async () => {
                await token.launchPaymasterUpdate(mockCallReceiver.address);
                await expectRevert(
                    token.launchPaymasterUpdate(mockCallReceiver.address),
                    "current update has to be executed",
                );
            });
        });
    });

    describe("cancelPaymasterUpdate", () => {
        let contract;

        before(async () => {
            contract = await MockCallReceiver.new();
        });

        beforeEach(async () => {
            await token.launchPaymasterUpdate(contract.address);
        });

        it("should reset update", async () => {
            const receipt = await token.cancelPaymasterUpdate();
            const update = await token.paymasterUpdate();

            assert((await token.paymaster()) === constants.ZERO_ADDRESS);
            assert(update[0] === constants.ZERO_ADDRESS);
            assert(update[1].toNumber() === 0);
            expectEvent(receipt, "PaymasterUpdateCancelled", {});
        });
    });

    describe("executePaymasterUpdate", async () => {
        // We need a contract address
        let contract;

        before(async () => {
            contract = await MockCallReceiver.new();
        });

        beforeEach(async () => {
            await token.launchPaymasterUpdate(contract.address);
        });

        context("should succeed", async () => {
            it("instantly when first update and called by owner", async () => {
                const receipt = await token.executePaymasterUpdate();
                const update = await token.paymasterUpdate();

                assert((await token.paymaster()) === contract.address);
                assert(update[0] === constants.ZERO_ADDRESS);
                assert(update[1].toNumber() === 0);
                expectEvent(receipt, "PaymasterUpdateExecuted", {
                    newPaymaster: contract.address,
                });
            });

            it("when not first update and called by owner and grace period ended", async () => {
                await token.executePaymasterUpdate();
                await token.launchPaymasterUpdate(contract.address);

                await time.increase(time.duration.weeks(1));
                const receipt = await token.executePaymasterUpdate();
                const update = await token.paymasterUpdate();

                assert((await token.paymaster()) === contract.address);
                assert(update[0] === constants.ZERO_ADDRESS);
                assert(update[1].toNumber() === 0);
                expectEvent(receipt, "PaymasterUpdateExecuted", {
                    newPaymaster: contract.address,
                });
            });
        });

        context("should fail", async () => {
            it("when not first update and grace period has not finished", async () => {
                await token.executePaymasterUpdate();
                await token.launchPaymasterUpdate(contract.address);

                await expectRevert(token.executePaymasterUpdate(), "grace period has not finished");
            });

            it("when update already executed", async () => {
                await time.increase(time.duration.weeks(1));
                await token.executePaymasterUpdate();
                await expectRevert(token.executePaymasterUpdate(), "update already executed");
            });
        });
    });

    describe("revokePaymaster", async () => {
        context("should succeed", async () => {
            it("when called", async () => {
                let receipt = await token.revokePaymaster(true, { from: user });
                let revoked = await token.paymasterRevoked(user);
                assert(revoked === true);
                expectEvent(receipt, "PaymasterRevoked", {
                    account: user,
                    revoked: true,
                });
                receipt = await token.revokePaymaster(false, { from: user });
                revoked = await token.paymasterRevoked(user);
                assert(revoked === false);
                expectEvent(receipt, "PaymasterRevoked", {
                    account: user,
                    revoked: false,
                });
            });
        });
    });

    describe("transferFrom", async () => {
        const amount = "1000000";
        let mockToken;

        before(async () => {
            mockToken = await MockToken.new("Test Token", "TT", 18, forwarder, paymaster);
            await mockToken.mint(user, toWei("100"));
        });

        context("should succeed", async () => {
            it("when from paymaster and not revoked", async () => {
                const initialBalance = await mockToken.balanceOf(paymaster);
                await mockToken.transferFrom(user, paymaster, amount, { from: paymaster });
                const finalBalance = await mockToken.balanceOf(paymaster);
                assert(finalBalance.sub(initialBalance).toNumber() === parseInt(amount, 10));
            });

            it("when not from paymaster and allowance", async () => {
                await mockToken.approve(receiver, amount, { from: user });
                const initialBalance = await mockToken.balanceOf(paymaster);
                await mockToken.transferFrom(user, paymaster, amount, { from: receiver });
                const finalBalance = await mockToken.balanceOf(paymaster);
                assert(finalBalance.sub(initialBalance).toNumber() === parseInt(amount, 10));
            });
        });

        context("should fail", async () => {
            it("when not from paymaster and no allowance", async () => {
                await expectRevert(
                    mockToken.transferFrom(user, paymaster, amount, { from: receiver }),
                    "ERC20: transfer amount exceeds allowance",
                );
            });

            it("when from paymaster and revoked", async () => {
                await mockToken.revokePaymaster(true, { from: user });
                await expectRevert(
                    mockToken.transferFrom(user, paymaster, amount, { from: paymaster }),
                    "ERC20: transfer amount exceeds allowance",
                );
            });
        });
    });

    describe("_msgSender", async () => {
        const amount = "100000";
        let data: string;

        beforeEach(async () => {
            // Call data for a transfer transaction for `amount` to `receiver`
            data = web3.eth.abi.encodeFunctionCall(
                {
                    name: "transfer",
                    type: "function",
                    inputs: [
                        {
                            type: "address",
                            name: "recipient",
                        },
                        {
                            type: "uint256",
                            name: "amount",
                        },
                    ],
                },
                [receiver, amount],
            );
        });

        context("should succeed", async () => {
            it("when from address is appended to data and sender is trusted forwarder", async () => {
                // Append the address of `user` so the contract will consider it is the sender
                const dataWithAddress = data + user.substr(2);

                // Transaction object with `forwarder` as sender
                const rawTransaction = {
                    from: forwarder,
                    to: token.address,
                    data: dataWithAddress,
                };

                const initialBalance = await token.balanceOf(receiver);
                await web3.eth.sendTransaction(rawTransaction);
                const finalBalance = await token.balanceOf(receiver);

                assert(finalBalance.sub(initialBalance).toNumber() === parseInt(amount, 10));
            });

            it("when no address appended to data and sender is not trusted forwarder", async () => {
                // Transaction object with `user` as sender
                const rawTransaction = {
                    from: user,
                    to: token.address,
                    data,
                };

                const initialBalance = await token.balanceOf(receiver);
                await web3.eth.sendTransaction(rawTransaction);
                const finalBalance = await token.balanceOf(receiver);

                assert(finalBalance.sub(initialBalance).toNumber() === parseInt(amount, 10));
            });
        });

        context("should fail", async () => {
            it("when from address is appended to data and sender is not trusted forwarder", async () => {
                // Append the address of `user` so the contract will consider it is the sender
                const dataWithAddress = data + user.substr(2);

                // Transaction object with `receiver` as sender
                const rawTransaction = {
                    from: user2,
                    to: token.address,
                    data: dataWithAddress,
                };

                await expectRevert(
                    web3.eth.sendTransaction(rawTransaction),
                    "ERC20: transfer amount exceeds balance",
                );
            });
        });
    });
});
