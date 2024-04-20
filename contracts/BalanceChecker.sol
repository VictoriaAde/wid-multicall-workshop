// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./interfaces/IMulticall3.sol";
import "./interfaces/IStruct.sol";

contract BalanceChecker is IStruct {
    IMulticall3 public multicall;
    address public tokenAddress;

    event BalanceChecked(address indexed user, uint256 balance);

    constructor(address _multicallAddress, address _tokenAddress) {
        multicall = IMulticall3(_multicallAddress);
        tokenAddress = _tokenAddress;
    }

    function getTokenBalances(
        address[] memory addresses
    ) external returns (uint256[] memory) {
        Call[] memory calls = new Call[](addresses.length);
        for (uint256 i = 0; i < addresses.length; i++) {
            calls[i] = Call(
                tokenAddress,
                abi.encodeWithSignature("balanceOf(address)", addresses[i])
            );
        }

        (, bytes[] memory returnData) = multicall.aggregate(calls);

        uint256[] memory balances = new uint256[](returnData.length);
        for (uint256 i = 0; i < returnData.length; i++) {
            balances[i] = abi.decode(returnData[i], (uint256));
            emit BalanceChecked(addresses[i], balances[i]);
        }

        return balances;
    }
}
