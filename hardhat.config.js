require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.20",
  networks: {
    ropsten: {
      url: "https://ropsten.infura.io/v3/YOUR_INFURA_PROJECT_ID",
      accounts: [`0x${YOUR_PRIVATE_KEY}`]
    }
  }
};
