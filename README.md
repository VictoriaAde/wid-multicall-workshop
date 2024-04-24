# Balance Checker Contract using Multicall3

The Balance Checker contract allows users to retrieve the token balances of multiple addresses efficiently using the Multicall V3 functionality. By aggregating multiple balanceOf calls into a single transaction, the contract minimizes gas costs and reduces blockchain congestion.
Users can interact with the contract to query the token balances of specified addresses, which are returned as an array of uint256 values. This contract demonstrates the use of Multicall3 to optimize on-chain data retrieval and improve overall efficiency in smart contract development.

## Contract Addresses

- Multicall sepolia: `0xcA11bde05977b3631167028862bE2a173976CA11`
- Vickish token sepolia: `0x07d1ad5b9f0752527e37b065a4752aedc28d0457`
- Seyi token sepolia: `0x6590bf931fEB2c4c063C937365c6ae644B164621`
- BalanceChecker: `0x2D5c929237a54E9276BBCaa81Fc6436172308DeA`
- BalanceChecker2: `0xc2433718502a483e0aa3E6cdA1c00ad61253c123`
- BalanceChecker3: `0x9aFCDd25C711c2F18e14792394c9fA0fBf5C7BB4`
- TwoTargetChecker: `0x33c6A81646c98e9d4e92f5A69893DAB4B6416c70`
- DoubleCallBalanceChecker: `0xb24A94DA20f9201cF2D4E62E5363befaCef5b0f5`

## Running project

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.ts
```
