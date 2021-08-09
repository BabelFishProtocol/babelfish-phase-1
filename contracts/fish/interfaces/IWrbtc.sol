/**
 * Copyright 2017-2020, bZeroX, LLC. All Rights Reserved.
 * Licensed under the Apache License, Version 2.0.
 */

pragma solidity ^0.5.17;

interface IWrbtc {
	function deposit() external payable;

	function withdraw(uint256 wad) external;
}
