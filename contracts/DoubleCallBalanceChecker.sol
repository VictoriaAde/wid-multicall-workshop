// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./interfaces/IMulticall3.sol";
import "./interfaces/IStruct.sol";

contract DoubleCallBalanceChecker is IStruct {
    IMulticall3 public multicall;
    address public vickishTKN;
    address public seyiTKN;

    event TokenBalanceChecked(
        address indexed user,
        uint256 indexed balanceVickishTKN,
        uint256 indexed balanceSeyiTKN
    );

    constructor(
        address _multicallAddress,
        address _vickishTKN,
        address _seyiTKN
    ) {
        multicall = IMulticall3(_multicallAddress);
        vickishTKN = _vickishTKN;
        seyiTKN = _seyiTKN;
    }

    function getTokenBalances(
        address[] calldata users
    ) external returns (uint256[][] memory) {
        IMulticall3.Call[] memory callsA = new IMulticall3.Call[](users.length);
        IMulticall3.Call[] memory callsB = new IMulticall3.Call[](users.length);

        for (uint256 i = 0; i < users.length; i++) {
            callsA[i] = Call(
                vickishTKN,
                abi.encodeWithSignature("balanceOf(address)", users[i])
            );

            callsB[i] = Call(
                seyiTKN,
                abi.encodeWithSignature("balanceOf(address)", users[i])
            );
        }

        IMulticall3.Result[] memory resultsA = multicall.tryAggregate(
            true,
            callsA
        );
        IMulticall3.Result[] memory resultsB = multicall.tryAggregate(
            true,
            callsB
        );

        // Extract the balances from the results
        uint256[][] memory balances = new uint256[][](2);
        balances[0] = new uint256[](users.length);
        balances[1] = new uint256[](users.length);

        for (uint256 i = 0; i < users.length; i++) {
            require(
                resultsA[i].success && resultsB[i].success,
                "DoubleCallBalanceChecker: Call failed"
            );

            balances[0][i] = abi.decode(resultsA[i].returnData, (uint256));
            balances[1][i] = abi.decode(resultsB[i].returnData, (uint256));
            emit TokenBalanceChecked(users[i], balances[0][i], balances[1][i]);
        }

        return balances;
    }
}
