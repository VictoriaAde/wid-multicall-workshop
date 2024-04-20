# Balance Checker Contract using Multicall3

The Balance Checker contract allows users to retrieve the token balances of multiple addresses efficiently using the Multicall V3 functionality. By aggregating multiple balanceOf calls into a single transaction, the contract minimizes gas costs and reduces blockchain congestion.
Users can interact with the contract to query the token balances of specified addresses, which are returned as an array of uint256 values. This contract demonstrates the use of Multicall3 to optimize on-chain data retrieval and improve overall efficiency in Ethereum smart contract development.

Running project

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.ts
```
