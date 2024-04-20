import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MULTICALL_ADDR = "0x000000000000000000";
const TOKEN_ADDR = "0x000000000000000000";

const BalanceModule = buildModule("BalanceModule", (m) => {
  const multicallAddress = m.getParameter("_multicallAddress", MULTICALL_ADDR);
  const tokenAddress = m.getParameter("_tokenAddress", TOKEN_ADDR);

  const bal = m.contract(
    "BalanceChecker",
    [multicallAddress, tokenAddress],
    {}
  );

  return { bal };
});

export default BalanceModule;
