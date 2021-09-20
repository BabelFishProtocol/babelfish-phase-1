pragma solidity ^0.5.17;
pragma experimental ABIEncoderV2;

import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import { IERC777Recipient } from "@openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";
import { IERC1820Registry } from "@openzeppelin/contracts/introspection/IERC1820Registry.sol";
import { InitializableOwnable } from "../../helpers/InitializableOwnable.sol";
import { InitializableReentrancyGuard } from "../../helpers/InitializableReentrancyGuard.sol";
import { IBridge } from "../IBridge.sol";
import { BasketManagerV3 } from "./BasketManagerV3.sol";
import { FeesVault } from "../../vault/FeesVault.sol";
import "../Token.sol";

/**
 * @title MassetV3
 * @dev Contract is responsible for managing mAsset and bAsset.
 * Used for minting and burning tokens, calculating fees and calling the bridge 
 * if transaction based on token from another blockchain.
 */

contract MassetV3 is IERC777Recipient, InitializableOwnable, InitializableReentrancyGuard {

    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    using SafeERC20 for Token;

    // events

    /**
     * @dev Emitted when deposit is completed.
     * @param minter            Address of the minter.
     * @param recipient         Address of the recipient.
     * @param massetQuantity    Masset quantity.
     * @param bAsset            Address of the bAsset.
     * @param bassetQuantity    Basset quantity.
     */
    event Minted(
        address indexed minter,
        address indexed recipient,
        uint256 massetQuantity,
        address bAsset,
        uint256 bassetQuantity
    );

    /**
     * @dev Emitted when withdrawal is completed.
     * @param redeemer          Address of the redeemer.
     * @param recipient         Address of the recipient.
     * @param massetQuantity    Masset quantity.
     * @param bAsset            Address of the bAsset.
     * @param bassetQuantity    Basset quantity.
     */
    event Redeemed(
        address indexed redeemer,
        address indexed recipient,
        uint256 massetQuantity,
        address bAsset,
        uint256 bassetQuantity
    );

    /**
     * @dev Emitted when tokensReceived method is called by the bridge.
     * @param operator         Address operator requesting the transfer.
     * @param from             Address token holder address.
     * @param to               Address recipient address.
     * @param amount           uint256 amount of tokens to transfer.
     * @param userData         Bytes extra information provided by the token holder (if any).
     * @param operatorData     Bytes extra information provided by the operator (if any).
     */
    event onTokensReceivedCalled(
        address operator,
        address from,
        address to,
        uint amount,
        bytes userData,
        bytes operatorData
    );

    /**
     * @dev Emitted when onTokensMinted method is called by the bridge.
     * @param sender           Address of the sender.
     * @param orderAmount      Units of the masset to redeem.
     * @param tokenAddress     Address of the bAsset to redeem.
     * @param userData         Address of the final recipient as ABI encoded bytes.
     */
    event onTokensMintedCalled(
        address indexed sender,
        uint256 orderAmount,
        address tokenAddress,
        bytes userData
    );

    /**
     * @dev Emitted when deposit fee has changed.
     * @param depositFee            Amount of the fee.
     */
    event DepositFeeChanged (uint256 depositFee);

    /**
     * @dev Emitted when deposit bridge fee has changed.
     * @param depositBridgeFee      Amount of the fee.
     */
    event DepositBridgeFeeChanged (uint256 depositBridgeFee);

    /**
     * @dev Emitted when withdrawal fee has changed.
     * @param withdrawalFee         Amount of the fee.
     */
    event WithdrawalFeeChanged (uint256 withdrawalFee);

    /**
     * @dev Emitted when withdrawal bridge fee has changed.
     * @param withdrawalBridgeFee   Amount of the fee.
     */
    event WithdrawalBridgeFeeChanged (uint256 withdrawalBridgeFee);

    // state

    /**
     * @dev Factor of fees.
     * @notice 1000 means that fees are in per mille.
     */
    uint256 constant private FEE_PRECISION = 1000;
    bytes32 constant ERC777_RECIPIENT_INTERFACE_HASH = keccak256("ERC777TokensRecipient");

    string private version;

    uint256 private depositFee;
    uint256 private depositBridgeFee;
    uint256 private withdrawalFee;
    uint256 private withdrawalBridgeFee;

    address private feesVaultAddress;
    BasketManagerV3 private basketManager;
    Token private token;

    // internal

    /**
     * @dev Register this contracts as implementer of the "ERC777 Tokens Recipient" interface in the ERC1820 registry.
     */
    function registerAsERC777Recipient() internal {
        IERC1820Registry ERC1820 = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
        ERC1820.setInterfaceImplementer(address(this), ERC777_RECIPIENT_INTERFACE_HASH, address(this));
    }

    /**
     * @dev Calculate and return fee amount based on massetAmount.
     * @param massetAmount  Amount of masset to deposit / withdraw.
     * @return fee          Calculated fee amount.
     */
    function calculateFee(uint256 massetAmount, uint256 feeAmount) internal pure returns(uint256 fee) {
        return massetAmount.mul(feeAmount).div(FEE_PRECISION);
    }

    // public

    /**
   * @dev Contract initializer.
   * @param _basketManagerAddress           Address of the basket manager.
   * @param _tokenAddress                   Address of the mAsset token.
   * @param _registerAsERC777RecipientFlag  Bool determine if contract should be register as ERC777 recipient.
   */
    function initialize(
        address _basketManagerAddress,
        address _tokenAddress,
        bool _registerAsERC777RecipientFlag) public {

        require(address(basketManager) == address(0) && address(token) == address(0), "already initialized");
        require(_basketManagerAddress != address(0), "invalid basket manager");
        require(_tokenAddress != address(0), "invalid token");

        InitializableOwnable._initialize();
        InitializableReentrancyGuard._initialize();

        basketManager = BasketManagerV3(_basketManagerAddress);
        token = Token(_tokenAddress);
        if(_registerAsERC777RecipientFlag) {
            registerAsERC777Recipient();
        }

        version = "1.0";
    }

    /***************************************
                MINTING (PUBLIC)
    ****************************************/

    /**
     * @dev Mint a single mAsset, at a 1:1 ratio with the bAsset. This contract
     *      must have approval to spend the senders bAsset.
     * @param _bAsset         Address of the bAsset.
     * @param _bAssetQuantity Quantity in bAsset units.
     * @return massetMinted   Number of newly minted mAssets.
     */
    function mint(
        address _bAsset,
        uint256 _bAssetQuantity
    )
    external
    nonReentrant
    returns (uint256 massetMinted)
    {
        return _mintTo(_bAsset, _bAssetQuantity, msg.sender);
    }

    /**
     * @dev Mint a single mAsset to recipient address, at a 1:1 ratio with the bAsset.
     *      This contract must have approval to spend the senders bAsset.
     * @param _bAsset         Address of the bAsset.
     * @param _bAssetQuantity Quantity in bAsset units.
     * @param _recipient      Receipient of the newly minted mAsset tokens.
     * @return massetMinted   Number of newly minted mAssets.
     */
    function mintTo(
        address _bAsset,
        uint256 _bAssetQuantity,
        address _recipient
    )
    external
    nonReentrant
    returns (uint256 massetMinted)
    {
        return _mintTo(_bAsset, _bAssetQuantity, _recipient);
    }

    /***************************************
              MINTING (INTERNAL)
    ****************************************/

    /**
     * @dev Mint a single mAsset to recipient address, at a 1:1 ratio with the bAsset.
     *      This contract must have approval to spend the senders bAsset.
     * @param _basset         Address of the bAsset.
     * @param _bassetQuantity Quantity in bAsset units.
     * @param _recipient      Receipient of the newly minted mAsset tokens.
     * @return massetMinted   Number of newly minted mAssets.
     */
    function _mintTo(
        address _basset,
        uint256 _bassetQuantity,
        address _recipient
    )
    internal
    returns (uint256 massetMinted)
    {
        require(_recipient != address(0), "must be a valid recipient");
        require(_bassetQuantity > 0, "quantity must not be 0");

        require(basketManager.isValidBasset(_basset), "invalid basset");
        require(basketManager.checkBasketBalanceForDeposit(_basset, _bassetQuantity), "invalid basket");

        (uint256 massetQuantity, uint256 bassetQuantity) = basketManager.convertBassetToMassetQuantity(_basset, _bassetQuantity);

        IERC20(_basset).safeTransferFrom(msg.sender, address(this), bassetQuantity);

        uint256 massetsToMint = _mintAndCalulateFee(massetQuantity, depositFee);
        token.mint(_recipient, massetsToMint);

        emit Minted(msg.sender, _recipient, massetsToMint, _basset, bassetQuantity);

        return massetsToMint;
    }

    /**
     * @dev Mints fee to vault contract and return the amount of massets that goes to the user.
     * @param massetQuantity    Amount of massets.
     * @return massetsToMint    Amount of massets that is left to mint for user.
     */
    function _mintAndCalulateFee(uint256 massetQuantity, uint256 feeAmount) internal returns (uint256 massetsToMint) {
        uint256 fee = calculateFee(massetQuantity, feeAmount);
        massetsToMint = massetQuantity.sub(fee);

        token.mint(feesVaultAddress, fee);

        return massetsToMint;
    }

    /***************************************
              REDEMPTION (PUBLIC)
    ****************************************/

    /**
     * @dev Credits the sender with a certain quantity of selected bAsset, in exchange for burning the
     *      relative mAsset quantity from the sender. Sender also incurs a small mAsset fee, if any.
     * @param _bAsset           Address of the bAsset to redeem.
     * @param _massetQuantity   Units of the masset to redeem.
     * @return massetMinted     Relative number of mAsset units burned to pay for the bAssets.
     */
    function redeem(
        address _bAsset,
        uint256 _massetQuantity
    ) external nonReentrant returns (uint256 massetRedeemed) {
        return _redeemTo(_bAsset, _massetQuantity, msg.sender, false);
    }

    /**
     * @dev Credits a recipient with a certain quantity of selected bAsset, in exchange for burning the
     *      relative mAsset quantity from the sender. Sender also incurs a small fee, if any.
     * @param _bAsset           Address of the bAsset to redeem.
     * @param _massetQuantity   Units of the masset to redeem.
     * @param _recipient        Address to credit with withdrawn bAssets.
     * @return massetMinted     Relative number of mAsset units burned to pay for the bAssets.
     */
    function redeemTo(
        address _bAsset,
        uint256 _massetQuantity,
        address _recipient
    ) external nonReentrant returns (uint256 massetRedeemed) {
        return _redeemTo(_bAsset, _massetQuantity, _recipient, false);
    }

    /***************************************
              REDEMPTION (INTERNAL)
    ****************************************/

    /**
     * @dev Credits a recipient with a certain quantity of selected bAsset, in exchange for burning the
     *      relative mAsset quantity from the sender. Sender also incurs a small fee, if any.
     * @param _basset           Address of the bAsset to redeem.
     * @param _massetQuantity   Units of the masset to redeem.
     * @param _recipient        Address to credit with withdrawn bAssets.
     * @param bridgeFlag        Flag that indicates if the reedem proces is used with conjunction with bridge.
     * @return massetMinted     Relative number of mAsset units burned to pay for the bAssets.
     */
    function _redeemTo(
        address _basset,
        uint256 _massetQuantity,
        address _recipient,
        bool bridgeFlag
    ) internal returns (uint256 massetRedeemed) {
        require(_recipient != address(0), "must be a valid recipient");
        require(_massetQuantity > 0, "masset quantity must be greater than 0");
        require(basketManager.isValidBasset(_basset), "invalid basset");

        uint256 feeAmount = bridgeFlag ? withdrawalBridgeFee : withdrawalFee;

        // massetsToBurn is the amount of massets that is left to burn after the fee was taken.
        // It is used to calculate amount of bassets that are transfered to user.
        uint256 massetsAfterFee = _transferAndCalulateFee(_massetQuantity, feeAmount, msg.sender);
        (uint256 bassetQuantity, uint256 massetsToBurn) = basketManager.convertMassetToBassetQuantity(_basset, massetsAfterFee);

        require(basketManager.checkBasketBalanceForWithdrawal(_basset, bassetQuantity), "invalid basket");

        token.burn(msg.sender, massetsToBurn);
        // In case of withdrawal to bridge the receiveTokensAt is called instead of transfer.
        if(bridgeFlag) {
            address bridgeAddress = basketManager.getBridge(_basset);
            require(bridgeAddress != address(0), "invalid bridge");
            IERC20(_basset).approve(bridgeAddress, bassetQuantity);
            require(
                IBridge(bridgeAddress).receiveTokensAt(_basset, bassetQuantity, _recipient, bytes("")),
                "call to bridge failed");
        } else {
            IERC20(_basset).safeTransfer(_recipient, bassetQuantity);
        }

        emit Redeemed(msg.sender, _recipient, _massetQuantity, _basset, bassetQuantity);

        return massetsToBurn;
    }

    /**
     * @dev Transfers fee to vault contract and return the amount of massets that will be burned
     *      must have approval to spend the senders Masset.
     * @param massetQuantity        Amount of massets to withdraw.
     * @param sender                Owner of massets.
     * @return massetsToBurn        Amount of massets that is left to burn.
     */
    function _transferAndCalulateFee(uint256 massetQuantity, uint256 feeAmount, address sender) internal returns (uint256 massetsToBurn) {
        uint256 fee = calculateFee(massetQuantity, feeAmount);
        massetsToBurn = massetQuantity.sub(fee);

        token.safeTransferFrom(sender, feesVaultAddress, fee);

        return massetsToBurn;
    }

    // For the BRIDGE

    /**
     * @dev Credits a recipient with a certain quantity of selected bAsset, in exchange for burning the
     *      relative Masset quantity from the sender. Sender also incurs a small fee, if any.
     *      This function is designed to also call the bridge in order to have the basset tokens sent to
     *      another blockchain.
     * @param _basset           Address of the bAsset to redeem.
     * @param _massetQuantity   Units of the masset to redeem.
     * @param _recipient        Address to credit with withdrawn bAssets.
     * @param _bridgeAddress    This is ignored and is left here for backward compatibility with the FE.
     * @return massetMinted     Relative number of mAsset units burned to pay for the bAssets.
     */
    function redeemToBridge(
        address _basset,
        uint256 _massetQuantity,
        address _recipient,
        address _bridgeAddress // IGNORED! for backward compatibility
    ) external nonReentrant returns (uint256 massetRedeemed) {
        return _redeemTo(_basset, _massetQuantity, _recipient, true);
    }

    /**
     * @dev Credits a recipient with a certain quantity of selected bAsset, in exchange for burning the
     *      relative Masset quantity from the sender. Sender also incurs a small fee, if any.
     *      This function is designed to also call the bridge in order to have the basset tokens sent to
     *      another blockchain.
     * @param _basset           Address of the bAsset to redeem.
     * @param _massetQuantity   Units of the masset to redeem.
     * @param _recipient        Address to credit with withdrawn bAssets.
     * @return massetMinted     Relative number of mAsset units burned to pay for the bAssets.
     */
    function redeemToBridge(
        address _basset,
        uint256 _massetQuantity,
        address _recipient
    ) external nonReentrant returns (uint256 massetRedeemed) {
        return _redeemTo(_basset, _massetQuantity, _recipient, true);
    }

    /**
     * @dev Decode bytes data to address.
     * @param data              Data to decode.
     * @return address          Decoded address.
     */
    function _decodeAddress(bytes memory data) private pure returns (address) {
        address addr = abi.decode(data, (address));
        require(addr != address(0), "Converter: Error decoding extraData");
        return addr;
    }

    /**
     * @dev Encode address to bytes data.
     * @param _address          Address to encode.
     * @return address          Decoded address.
     */
    function _encodeAddress(address _address) private pure returns (bytes memory) {
        require(_address != address(0), "Converter: Error encoding extraData");
        return abi.encode(_address);
    }

    /**
     * @dev This is called by the bridge to let us know tokens have been received.
     * @param _operator         Address operator requesting the transfer.
     * @param _from             Address token holder address.
     * @param _to               Address recipient address.
     * @param _amount           uint256 amount of tokens to transfer.
     * @param _userData         Bytes extra information provided by the token holder (if any).
     * @param _operatorData     Bytes extra information provided by the operator (if any).
     */
    function tokensReceived(
        address _operator,
        address _from,
        address _to,
        uint _amount,
        bytes calldata _userData,
        bytes calldata _operatorData
    ) external {
        emit onTokensReceivedCalled(
            _operator,
            _from,
            _to,
            _amount,
            _userData,
            _operatorData
        );
    }

    /**
     * @dev This is called by the bridge to let us know the user has sent tokens through it and
     *      into the masset.
     * @param _orderAmount      Units of the masset to redeem.
     * @param _tokenAddress     Address of the bAsset to redeem.
     * @param _userData         Address of the final recipient as ABI encoded bytes.
     */
    function onTokensMinted(
        uint256 _orderAmount,
        address _tokenAddress,
        bytes calldata _userData
    ) external nonReentrant {
        emit onTokensMintedCalled(msg.sender, _orderAmount, _tokenAddress, _userData);

        require(_orderAmount > 0, "amount must be > 0");

        address recipient =  _decodeAddress(_userData);
        address basset = _tokenAddress;

        address bridgeAddress = basketManager.getBridge(basset);
        require(msg.sender == bridgeAddress, "only bridge may call");

        require(basketManager.isValidBasset(basset), "invalid basset");
        require(basketManager.checkBasketBalanceForDeposit(basset, _orderAmount), "basket out of balance");

        (uint256 massetQuantity, uint256 bassetQuantity) = basketManager.convertBassetToMassetQuantity(basset, _orderAmount);
        uint256 massetsToMint = _mintAndCalulateFee(massetQuantity, depositBridgeFee);
        token.mint(recipient, massetsToMint);

        emit Minted(msg.sender, recipient, massetsToMint, basset, bassetQuantity);
    }

    // Getters

    function getVersion() external view returns (string memory) {
        return version;
    }

    function getToken() external view returns (address) {
        return address(token);
    }

    function getBasketManager() external view returns (address) {
        return address(basketManager);
    }

    function getDepositFee () external view returns(uint256) {
        return depositFee;
    }

    function getDepositBridgeFee () external view returns(uint256) {
        return depositBridgeFee;
    }

    function getWithdrawalFee () external view returns(uint256) {
        return withdrawalFee;
    }

    function getWithdrawalBridgeFee () external view returns(uint256) {
        return withdrawalBridgeFee;
    }

    // Governance methods

    function setDepositFee (uint256 _amount) public onlyOwner {
        require(_amount >= 0, "fee amount should be greater or equal zero");
        depositFee = _amount;

        emit DepositFeeChanged(_amount);
    }

    function setDepositBridgeFee (uint256 _amount) public onlyOwner {
        require(_amount >= 0, "fee amount should be greater or equal zero");
        depositBridgeFee = _amount;

        emit DepositBridgeFeeChanged(_amount);
    }

    function setWithdrawalFee (uint256 _amount) public onlyOwner {
        require(_amount >= 0, "fee amount should be greater or equal zero");
        withdrawalFee = _amount;

        emit WithdrawalFeeChanged(_amount);
    }

    function setWithdrawalBridgeFee (uint256 _amount) public onlyOwner {
        require(_amount >= 0, "fee amount should be greater or equal zero");
        withdrawalBridgeFee = _amount;

        emit WithdrawalBridgeFeeChanged(_amount);
    }

    // Temporary migration
    /**
     * @dev Temporary migration to V3 version.
     */
    function upgradeToV3(
        address _basketManagerAddress,
        address _tokenAddress,
        address _feesVaultAddress,
        uint256 _depositFee,
        uint256 _depositBridgeFee,
        uint256 _withdrawalFee,
        uint256 _withdrawalBridgeFee
    ) external {
        require(
            keccak256(bytes(version)) == keccak256(bytes("1.0")) ||
            keccak256(bytes(version)) == keccak256(bytes("2.0")), "wrong version (1)");
        require(keccak256(bytes(BasketManagerV3(_basketManagerAddress).getVersion())) == keccak256(bytes("3.0")), "wrong version (2)");
        require(_feesVaultAddress != address(0), "invalid vault address");

        setDepositFee(_depositFee);
        setDepositBridgeFee(_depositBridgeFee);
        setWithdrawalFee(_withdrawalFee);
        setWithdrawalBridgeFee(_withdrawalBridgeFee);

        feesVaultAddress = _feesVaultAddress;
        basketManager = BasketManagerV3(_basketManagerAddress);
        token = Token(_tokenAddress);
        version = "3.0";
        InitializableReentrancyGuard._initialize();
    }
}