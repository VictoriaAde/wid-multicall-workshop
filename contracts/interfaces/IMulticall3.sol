// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "./IStruct.sol";

interface IMulticall3 is IStruct {
    function aggregate(
        Call[] calldata calls
    ) external payable returns (uint256 blockNumber, bytes[] memory returnData);
    function tryAggregate(
        bool requireSuccess,
        Call[] calldata calls
    ) external payable returns (Result[] memory returnData);
    function aggregate3(
        Call3[] calldata calls
    ) external payable returns (Result[] memory returnData);
}
