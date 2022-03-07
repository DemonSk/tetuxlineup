require("dotenv").config();
const HDWalletProvider = require("@truffle/hdwallet-provider");

const privateKey = process.env.PRIVAT_KEY;
const infuraURL = process.env.INFURA_URL;

module.exports = {
  plugins: ["truffle-plugin-verify"],
  networks: {
    development: {
      host: "127.0.0.1", // Localhost (default: none)
      port: 7545, // Standard Ethereum port (default: none)
      network_id: "*", // Any network (default: none)
    },
    rinkeby: {
      provider: () => new HDWalletProvider(privateKey, infuraURL),
      gas: 5000000,
      gasPrice: 25000000000,
      network_id: 4, // rinkeby's id
      websocket: true,
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    timeout: 1000000,
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.10", // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    },
  },
  api_keys: {
    etherscan: process.env.ETHERSCAN_API_KEY,
  },
};
