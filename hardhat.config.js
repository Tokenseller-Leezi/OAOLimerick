require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  defaultNetwork: "sepolia",
  networks: {
    hardhat: {},
    localnet: {
      url: process.env.LOCAL_ENDPOINT,
      accounts: [process.env.KEY],
    },
    sepolia: {
      url: process.env.SEPOLIA_ENDPOINT,
      accounts: [process.env.KEY],
    },
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN,
    },
  },
};
