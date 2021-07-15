pragma solidity 0.5.16;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { MassetV3 } from "../../masset/MassetV3.sol";

contract MockBridge {
    function receiveTokensAt(
        address tokenToUse,
        uint256 amount,
        address receiver,
        bytes calldata extraData
    ) external returns(bool) {
        require(IERC20(tokenToUse).transferFrom(msg.sender, address(this), amount), "transfer failed");

        return true;
    }

    // It is used to test the case, when bridge is calling the onTokensMinted method on MassetV3
    function callOnTokensMinted(
        address masset,
        uint256 _orderAmount,
        address _tokenAddress,
        address _userData
    ) external {
        MassetV3(masset).onTokensMinted(_orderAmount, _tokenAddress, abi.encode(_userData));
    }
}