// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./interfaces/IMulticall3.sol";
import "./interfaces/IStruct.sol";

contract BalanceChecker2 is IStruct {
    IMulticall3 public multicall;
    address public tokenAddress;

    event BalanceChecked(address indexed user, uint256 balance);

    constructor(address _multicallAddress, address _tokenAddress) {
        multicall = IMulticall3(_multicallAddress);
        tokenAddress = _tokenAddress;
    }

    function getTokenBalancesWithTryAggregate(
        address[] memory addresses
    ) public returns (uint256[] memory) {
        Call[] memory calls = new Call[](addresses.length);
        for (uint256 i = 0; i < addresses.length; i++) {
            // Encode the call to the balanceOf function of the ERC20 token contract
            // The first argument is the address of the token contract, and the second argument is the address to check the balance of
            calls[i] = Call(
                tokenAddress,
                abi.encodeWithSignature("balanceOf(address)", addresses[i])
            );
        }

        IMulticall3.Result[] memory results = multicall.tryAggregate(
            true,
            calls
        );

        uint256[] memory balances = new uint256[](results.length);
        for (uint256 i = 0; i < results.length; i++) {
            require(results[i].success, "BalanceChecker2: Call failed");
            balances[i] = abi.decode(results[i].returnData, (uint256));
            emit BalanceChecked(addresses[i], balances[i]);
        }

        return balances;
    }
}
