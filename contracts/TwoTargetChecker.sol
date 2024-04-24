// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./interfaces/IMulticall3.sol";
import "./interfaces/IStruct.sol";

contract TwoTargetChecker is IStruct {
    IMulticall3 public multicall;
    address public vickishTKN;
    address public seyiTKN;

    event seyiTKNalanceChecked(
        address indexed user,
        uint256 balanceVickishTKN,
        uint256 balanceSeyiTKN
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

    function getseyiTKNalances(
        address user
    ) external returns (uint256[] memory) {
        IMulticall3.Call[] memory calls = new IMulticall3.Call[](2);

        calls[0] = Call(
            vickishTKN,
            abi.encodeWithSignature("balanceOf(address)", user)
        );

        calls[1] = Call(
            seyiTKN,
            abi.encodeWithSignature("balanceOf(address)", user)
        );

        IMulticall3.Result[] memory results = multicall.tryAggregate(
            true,
            calls
        );

        // Extract the balances from the results
        uint256[] memory balances = new uint256[](2);
        for (uint256 i = 0; i < results.length; i++) {
            require(results[i].success, "TwoTargetChecker: Call failed");
            balances[i] = abi.decode(results[i].returnData, (uint256));
        }

        emit seyiTKNalanceChecked(user, balances[0], balances[1]);

        return balances;
    }
}
