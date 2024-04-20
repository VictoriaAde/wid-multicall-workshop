// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./interfaces/IMulticall3.sol";
import "./interfaces/IStruct.sol";

contract BalanceChecker3 is IStruct {
    IMulticall3 public multicall;
    address public tokenAddress;

    constructor(address _multicallAddress, address _tokenAddress) {
        multicall = IMulticall3(_multicallAddress);
        tokenAddress = _tokenAddress;
    }

    function getTokenBalancesWithAggregate3(
        address[] memory addresses
    ) public returns (uint256[] memory) {
        // Prepare an array of Call3 structs
        IMulticall3.Call3[] memory calls = new IMulticall3.Call3[](
            addresses.length
        );
        for (uint256 i = 0; i < addresses.length; i++) {
            // Set allowFailure to true to allow individual calls to fail without reverting the entire transaction
            // Encode the call to the balanceOf function of the ERC20 token contract
            // The first argument is the address of the token contract, and the second argument is the address to check the balance of
            calls[i] = Call3(
                tokenAddress,
                true,
                abi.encodeWithSignature("balanceOf(address)", addresses[i])
            );
        }

        IMulticall3.Result[] memory results = multicall.aggregate3(calls);

        uint256[] memory balances = new uint256[](results.length);
        for (uint256 i = 0; i < results.length; i++) {
            require(results[i].success, "BalanceChecker3: Call failed");
            balances[i] = abi.decode(results[i].returnData, (uint256));
        }

        return balances;
    }
}
