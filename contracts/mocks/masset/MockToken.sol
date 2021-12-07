pragma solidity ^0.5.17;

import "../../masset/Token.sol";

contract MockToken is Token {
	constructor (
		string memory _name,
        string memory _symbol,
        uint8 _decimals,
        address _forwarder,
		address _paymaster
	) public Token(_name, _symbol, _decimals, _forwarder) {
		paymaster = _paymaster;
	}
}