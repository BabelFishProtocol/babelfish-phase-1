pragma solidity 0.5.16;
pragma experimental ABIEncoderV2;

import { BasketManager } from "./BasketManager.sol";
import { SafeMath } from "../openzeppelin/contracts/math/SafeMath.sol";
import { IERC20 } from "../openzeppelin/contracts/token/ERC20/IERC20.sol";
import { IERC777Recipient } from "../openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";
import { IERC1820Registry } from "../openzeppelin/contracts/introspection/IERC1820Registry.sol";
import { IBridge } from "./IBridge.sol";
import { InitializableOwnable } from "../helpers/InitializableOwnable.sol";
import "./Token.sol";
import { InitializableReentrancyGuard } from "../helpers/InitializableReentrancyGuard.sol";
import "./ApprovalReceiver.sol";
import "./BaseRelayRecipient.sol";


contract Masset is IERC777Recipient, InitializableOwnable, InitializableReentrancyGuard, ApprovalReceiver, BaseRelayRecipient {

    using SafeMath for uint256;

    // Events

    event Minted(
        address indexed minter,
        address indexed recipient,
        uint256 massetQuantity,
        address bAsset,
        uint256 bassetQuantity);

    event Redeemed(
        address indexed redeemer,
        address indexed recipient,
        uint256 massetQuantity,
        address bAsset,
        uint256 bassetQuantity,
        bytes userData);

    event onTokensReceivedCalled(
        address operator,
        address from,
        address to,
        uint amount,
        bytes userData,
        bytes operatorData
    );

    event onTokensMintedCalled(
        address indexed sender,
        uint256 orderAmount,
        address tokenAddress,
        bytes userData
    );

    event onSetBasketManager(address indexed sender, address indexed oldBasketManager, address indexed newBaskManager);
    event onSetToken(address indexed sender, address indexed oldToken, address indexed newToken);
    event onSetTokenOwner(address indexed sender, address indexed oldTokenOwner, address indexed newTokenOwner);

    // state

    string private version;
    BasketManager private basketManager;
    Token private token;
    
    // internal

    function registerAsERC777Recipient() internal {
        IERC1820Registry ERC1820 = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
        ERC1820.setInterfaceImplementer(address(this), keccak256("ERC777TokensRecipient"), address(this));
    }

    // public

    function initialize(
        address _basketManagerAddress,
        address _tokenAddress,
        bool _registerAsERC777RecipientFlag,
        address _forwarder) public {

        require(address(basketManager) == address(0) && address(token) == address(0), "already initialized");
        require(_basketManagerAddress != address(0), "invalid basket manager");
        require(_tokenAddress != address(0), "invalid token");

        InitializableOwnable._initialize();
        InitializableReentrancyGuard._initialize();

        basketManager = BasketManager(_basketManagerAddress);
        token = Token(_tokenAddress);
        if(_registerAsERC777RecipientFlag) {
            registerAsERC777Recipient();
        }

        _trustedForwarder = _forwarder;

        version = "1.0";
    }

    /***************************************
                MINTING (PUBLIC)
    ****************************************/

    /**
     * @dev Mint a single bAsset, at a 1:1 ratio with the bAsset. This contract
     *      must have approval to spend the senders bAsset
     * @param _bAsset         Address of the bAsset to mint
     * @param _bAssetQuantity Quantity in bAsset units
     * @return massetMinted   Number of newly minted mAssets
     */
    function mint(
        address _bAsset,
        uint256 _bAssetQuantity
    )
    external
    nonReentrant
    returns (uint256 massetMinted)
    {
        return _mintTo(_bAsset, _bAssetQuantity, _msgSender());
    }

    /**
     * @dev Mint a single bAsset, at a 1:1 ratio with the bAsset. This contract
     *      must have approval to spend the senders bAsset
     * @param _bAsset         Address of the bAsset to mint
     * @param _bAssetQuantity Quantity in bAsset units
     * @param _recipient receipient of the newly minted mAsset tokens
     * @return massetMinted   Number of newly minted mAssets
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
        require(basketManager.checkBasketBalanceForDeposit(_basset, _bassetQuantity));

        address msgSender = _msgSender();

        uint256 massetQuantity = basketManager.convertBassetToMassetQuantity(_basset, _bassetQuantity);

        IERC20(_basset).transferFrom(msgSender, address(this), _bassetQuantity);

        token.mint(_recipient, massetQuantity);
        emit Minted(msgSender, _recipient, massetQuantity, _basset, _bassetQuantity);

        return massetQuantity;
    }

    /***************************************
              REDEMPTION (PUBLIC)
    ****************************************/

    /**
     * @dev Credits the sender with a certain quantity of selected bAsset, in exchange for burning the
     *      relative mAsset quantity from the sender. Sender also incurs a small mAsset fee, if any.
     * @param _bAsset           Address of the bAsset to redeem
     * @param _massetQuantity   Units of the masset to redeem
     * @return massetMinted     Relative number of mAsset units burned to pay for the bAssets
     */

    function redeem(
        address _bAsset,
        uint256 _massetQuantity
    ) external nonReentrant returns (uint256 massetRedeemed) {
        address msgSender = _msgSender();
        return _redeemTo(_bAsset, _massetQuantity, msgSender, bytes(""), false, msgSender);
    }

    /**
     * @dev Credits a recipient with a certain quantity of selected bAsset, in exchange for burning the
     *      relative Masset quantity from the sender. Sender also incurs a small fee, if any.
     * @param _bAsset           Address of the bAsset to redeem
     * @param _massetQuantity   Units of the masset to redeem
     * @param _recipient        Address to credit with withdrawn bAssets
     * @return massetMinted     Relative number of mAsset units burned to pay for the bAssets
     */
    function redeemTo(
        address _bAsset,
        uint256 _massetQuantity,
        address _recipient
    ) external nonReentrant returns (uint256 massetRedeemed) {
        return _redeemTo(_bAsset, _massetQuantity, _recipient, bytes(""), false, _msgSender());
    }

    /***************************************
              REDEMPTION (INTERNAL)
    ****************************************/

        function _redeemTo(
        address _basset,
        uint256 _massetQuantity,
        address _recipient,
        bytes memory userData,
        bool bridgeFlag,
        address _sender
    ) internal returns (uint256 massetRedeemed) {
        require(_recipient != address(0), "must be a valid recipient");
        require(_massetQuantity > 0, "masset quantity must be greater than 0");
        require(basketManager.isValidBasset(_basset), "invalid basset");

        uint256 bassetQuantity = basketManager.convertMassetToBassetQuantity(_basset, _massetQuantity);

        require(basketManager.checkBasketBalanceForWithdrawal(_basset, bassetQuantity));

        if(bridgeFlag) {
            address bridgeAddress = basketManager.getBridge(_basset);
            require(bridgeAddress != address(0), "invalid bridge");
            IERC20(_basset).approve(bridgeAddress, bassetQuantity);
            require(
                IBridge(bridgeAddress).receiveTokensAt(_basset, bassetQuantity, _recipient, userData),
                "call to bridge failed");
        } else {
            IERC20(_basset).transfer(_recipient, bassetQuantity);
        }
    
    // // {_senderApproval != address(0)} only for valid invokation from receiveApproval
    //     address _sender;
    //     if(_senderApproval != address(0)) {
    //         _sender = _senderApproval;
    //         _senderApproval = address(0);
    //     } else {
    //         _sender = _msgSender();
    //     }
        
        token.burn(_sender, _massetQuantity);
        emit Redeemed(_sender, _recipient, _massetQuantity, _basset, bassetQuantity, userData);

        return _massetQuantity;
    }


    /**
     * @dev Credits a recipient with a certain quantity of selected bAsset, in exchange for burning the
     *      relative Masset quantity from the sender. Sender also incurs a small fee, if any.
     *      This function is designed to also call the bridge in order to have the basset tokens sent to
     *      another blockchain.
     * @param _basset           Address of the bAsset to redeem
     * @param _massetQuantity   Units of the masset to redeem
     * @param _recipient        Address to credit with withdrawn bAssets
     * @param _userData         For FastBTC: RSK address and BTC address encoded
     * @return massetMinted     Relative number of mAsset units burned to pay for the bAssets
     */
    function redeemToBridge(
        address _basset,
        uint256 _massetQuantity,
        address _recipient,
        bytes calldata _userData
    ) external nonReentrant returns (uint256 massetRedeemed) {
        return _redeemTo(_basset, _massetQuantity, _recipient, _userData, true, _msgSender());
    }

    /**
	 * @notice transfer tokens to the aggregator
	 * @dev This function will be invoked from receiveApproval.
	 * @dev BTCs.approveAndCall -> this.receiveApproval -> this.redeemToBridgeWithApproval
     * @param _sender           Address of the sender, validated by receiveApproval()
     * @param _basset           Address of the bAsset to redeem
     * @param _massetQuantity   Units of the masset to redeem
     * @param _recipient        Address to credit with withdrawn bAssets
     * @param _userData         For FastBTC: RSK address and BTC address encoded
	 * */
	function redeemToBridgeWithApproval(
        address _sender,
        uint256 _massetQuantity,
        address _basset,
        address _recipient,
        bytes memory _userData
    ) public onlyThisContract returns (uint256 massetRedeemed) {
        return _redeemTo(_basset, _massetQuantity, _recipient, _userData, true, _sender);
    }
        
    function _decodeAddress(bytes memory data) private pure returns (address) {
        address addr = abi.decode(data, (address));
        require(addr != address(0), "Converter: Error decoding extraData");
        return addr;
    }

    function _encodeAddress(address _address) private pure returns (bytes memory) {
        require(_address != address(0), "Converter: Error encoding extraData");
        return abi.encode(_address);
    }

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
     * @param _orderAmount      Units of the masset to redeem
     * @param _tokenAddress     Address of the bAsset to redeem
     * @param _userData         Address of the final recipient as ABI encoded bytes
     */
    function onTokensMinted(
        uint256 _orderAmount,
        address _tokenAddress,
        bytes calldata _userData
    ) external nonReentrant {
        address msgSender = _msgSender();
        emit onTokensMintedCalled(msgSender, _orderAmount, _tokenAddress, _userData);

        require(_orderAmount > 0, "amount must be > 0");

        address recipient =  _decodeAddress(_userData);
        address basset = _tokenAddress;

        address bridgeAddress = basketManager.getBridge(basset);
        require(msgSender == bridgeAddress, "only bridge may call");

        require(basketManager.isValidBasset(basset), "invalid basset");
        require(basketManager.checkBasketBalanceForDeposit(basset, _orderAmount), "basket out of balance");

        uint256 massetQuantity = basketManager.convertBassetToMassetQuantity(basset, _orderAmount);
        token.mint(recipient, massetQuantity);
        emit Minted(msgSender, recipient, massetQuantity, basset, _orderAmount);
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

    // Admin functions

    function setBasketManager(address _basketManagerAddress) public onlyOwner {
        require(_basketManagerAddress != address(0), "address invalid");
        require(_basketManagerAddress != address(basketManager), "same address");

        emit onSetBasketManager(_msgSender(), address(basketManager), _basketManagerAddress);
        basketManager = BasketManager(_basketManagerAddress);
    }

    function setToken(address _tokenAddress) public onlyOwner {
        require(_tokenAddress != address(0), "address invalid");
        require(_tokenAddress != address(token), "same address");

        emit onSetToken(_msgSender(), address(token), _tokenAddress);
        token = Token(_tokenAddress);
    }

    function setTokenOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "address invalid");
        require(_newOwner != token.owner(), "same address");

        emit onSetTokenOwner(_msgSender(), token.owner(), _newOwner);
        token.transferOwnership(_newOwner);
    }

    /**
	 * @notice Overrides default ApprovalReceiver._getToken function to
	 * register BTCs token on this contract.
	 * @return The address of BTCs token.
	 * */
	function _getToken() internal view returns (address) {
		return address(token);
	}

	/**
	 * @notice Overrides default ApprovalReceiver._getSelectors function to
	 * register redeemToBridgeWithApproval selector on this contract.
	 * @return The array of registered selectors on this contract.
	 * */
	function _getSelectors() internal view returns (bytes4[] memory) {
		bytes4[] memory selectors = new bytes4[](1);
		selectors[0] = this.redeemToBridgeWithApproval.selector;
		return selectors;
	}

    /**
     * @dev Sets the global implementation of _msgSender() to the BaseRelayRecipient one.
     */
    function _msgSender() internal view returns (address payable ret) {
        // Forces to use _msgSender() from BaseRelayRecipient instead of Context
        return BaseRelayRecipient._msgSender();
    }

    // Temporary migration code

    function migrateV1ToV2() public {
        version = "2.0";
    }

    address[] assets;
    int256[] factors;
    address[] bridges;

    function migrateV22ToV23() public {
        require(
            keccak256(bytes(version)) == keccak256(bytes("2.2")), "wrong version");

        uint256 chainId;
        assembly {
            chainId := chainid()
        }

        assets.length = 0;
        factors.length = 0;
        bridges.length = 0;

        version = "2.3";

        // testnet
        if (chainId == 31) {

            // ETH->RSK

            assets.push(0xcB92c8d49Ec01b92f2a766C7c3C9C501C45271e0); // DAIes
            factors.push(int256(1));
            bridges.push(0xC0E7A7FfF4aBa5e7286D5d67dD016B719DCc9156);

            assets.push(0xCc8EEc21aE75f1A2DE4aC7b32a7de888A45cF859); // USDCes
            factors.push(int256(1));
            bridges.push(0xC0E7A7FfF4aBa5e7286D5d67dD016B719DCc9156);

            assets.push(0x10C5A7930fc417E728574e334b1488b7895C4b81); // USDTes
            factors.push(int256(1));
            bridges.push(0xC0E7A7FfF4aBa5e7286D5d67dD016B719DCc9156);

            // BSC->RSK

            assets.push(0x407Ff7D4760d3a81b4740D268eb04490C7dFE7f2); // bsDAI
            factors.push(int256(1));
            bridges.push(0x2b2BCAD081fA773DC655361d1Bb30577Caa556F8);

            assets.push(0x3e2cf87e7fF4048A57F9Cdde9368C9f4bfb43aDf); // bsUSDC
            factors.push(int256(1));
            bridges.push(0x2b2BCAD081fA773DC655361d1Bb30577Caa556F8);

            assets.push(0x43bC3f0FfFf6c9BBf3C2EAfe464C314d43f561De); // bsUSDT
            factors.push(int256(1));
            bridges.push(0x2b2BCAD081fA773DC655361d1Bb30577Caa556F8);

            assets.push(0x8c9abb6c9D8D15ddB7ada2e50086e1050aB32688); // bsBUSD
            factors.push(int256(1));
            bridges.push(0x2b2BCAD081fA773DC655361d1Bb30577Caa556F8);

            // non bridge

            assets.push(0xC3De9F38581f83e281f260d0DdbaAc0e102ff9F8); // rDOC
            factors.push(int256(1));
            bridges.push(0x0000000000000000000000000000000000000000);

            assets.push(0xCB46c0ddc60D18eFEB0E586C17Af6ea36452Dae0); // DOC
            factors.push(int256(1));
            bridges.push(0x0000000000000000000000000000000000000000);

            basketManager = new BasketManager(assets, factors, bridges);
        }

        // mainnet
        if (chainId == 30) {

            // ETH->RSK
            assets.push(0x1a37c482465e78E6dabE1eC77b9A24d4236D2A11); // DAIes
            factors.push(int256(1));
            bridges.push(0x1CcAd820B6d031B41C54f1F3dA11c0d48b399581);

            assets.push(0x8D1F7cBC6391d95E2774380E80a666fEBf655d6B); // USDCes
            factors.push(int256(1));
            bridges.push(0x1CcAd820B6d031B41C54f1F3dA11c0d48b399581);

            assets.push(0xD9665Ea8F5Ff70CF97e1b1CD1B4Cd0317B0976e8); // USDTes
            factors.push(int256(1));
            bridges.push(0x1CcAd820B6d031B41C54f1F3dA11c0d48b399581);

            // BSC->RSK
            assets.push(0x6A42FF12215a90F50866a5CE43a9c9c870116E76); // DAIbs
            factors.push(int256(1));
            bridges.push(0x971B97C8cc82E7D27Bc467C2DC3F219c6eE2e350);

            assets.push(0x91eDceE9567cD5612C9DeDeAAe24D5e574820Af1); // USDCbs
            factors.push(int256(1));
            bridges.push(0x971B97C8cc82E7D27Bc467C2DC3F219c6eE2e350);

            assets.push(0xFf4299bcA0313c20A61dC5Ed597739743bEf3f6D); // USDTbs
            factors.push(int256(1));
            bridges.push(0x971B97C8cc82E7D27Bc467C2DC3F219c6eE2e350);

            assets.push(0x61e9604E31a736129D7f5c58964C75935b2D80d6); // BUSDbs
            factors.push(int256(1));
            bridges.push(0x971B97C8cc82E7D27Bc467C2DC3F219c6eE2e350);

            // non bridge
            assets.push(0xef213441A85dF4d7ACbDaE0Cf78004e1E486bB96); // RUSDT
            factors.push(int256(1));
            bridges.push(0x0000000000000000000000000000000000000000);

            assets.push(0x2d919F19D4892381D58edeBeca66D5642Cef1a1f); // rDOC
            factors.push(int256(1));
            bridges.push(0x0000000000000000000000000000000000000000);

            assets.push(0xe700691dA7b9851F2F35f8b8182c69c53CcaD9Db); // DOC
            factors.push(int256(1));
            bridges.push(0x0000000000000000000000000000000000000000);

            basketManager = new BasketManager(assets, factors, bridges);
        }
    }
}
