require('ts-node/register')
// OPTIONAL: Allows the use of tsconfig path mappings with ts-node
require('tsconfig-paths/register')

const HDWalletProvider = require('@truffle/hdwallet-provider')
const fs = require('fs');

const secrets = JSON.parse(
  fs.readFileSync("./../../../deploy_bridge/bridgeKeyMain/.secrets").toString().trim()
);
let MNEMONIC = fs.existsSync('../../../bridgeKey/mnemonic.key') ? fs.readFileSync('../../../bridgeKey/mnemonic.key', { encoding: 'utf8' }) : "";// Your metamask's recovery words

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!

  migrations_directory: './migrations',
  contracts_build_directory: './build/contracts',
  plugins: ['solidity-coverage', 'truffle-plugin-verify'],
  api_keys: {
    etherscan: ''
  },
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*', // Match any network id
      gas: 6721975,
      gasPrice: 0x01
    },
    fork: {
      host: '127.0.0.1',
      port: 7545,
      network_id: '*', // Match any network id
      gas: 8000000
    },
    coverage: {
      host: "127.0.0.1",
      port: 7546,
      network_id: "*",
      gas: 0xfffffffffff, // <-- Use this high gas value
      gasPrice: 0x01      // <-- Use this low gas price
    },
    ropsten: {
      provider() {
        return new HDWalletProvider("seek danger physical menu pen arrest clutch blade weird detect digital frog",
            `wss://ropsten.infura.io/ws/v3/42af85fbc97845a0974cbbf003834c28`, 0, 3)
      },
      network_id: 3,
      gasPrice: 1000000000, // 100 GWei,
      skipDryRun: true,
      gas: 7000000
    },
    kovan: {
      provider() {
        return new HDWalletProvider("seek danger physical menu pen arrest clutch blade weird detect digital frog",
            "wss://kovan.infura.io/ws/v3/42af85fbc97845a0974cbbf003834c28", 0, 42)
      },
      network_id: 42,
      gasPrice: 20000000000, // 20 GWei,
      skipDryRun: true,
      gas: 2000000
    },
    rskTestnet: {
      provider() {
        return new HDWalletProvider('chimney toss kit now firm true scan laundry hazard buffalo tiny west',
            //'https://testnet.sovryn.app/rpc',
            'https://public-node.testnet.rsk.co',
            0, 31)
      },
      network_id: 31,
      gasPrice: 71680400, // 71GWei,
      skipDryRun: true,
      networkCheckTimeout: 1e9
    },
    //Binance
    btestnet: {
      //provider: () => new HDWalletProvider(MNEMONIC, "https://data-seed-prebsc-1-s1.binance.org:8545/"),
      provider() {
       // return new HDWalletProvider(MNEMONIC, "https://data-seed-prebsc-2-s3.binance.org:8545/", 0, 97)
        //return new HDWalletProvider(MNEMONIC, "https://data-seed-prebsc-1-s1.binance.org:8545/", 0, 97)
        return new HDWalletProvider(MNEMONIC, "https://data-seed-prebsc-2-s2.binance.org:8545/", 0, 97)
      },
      //
      network_id: 97,
      gas: 6300000,
      confirmations: 3,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    bmainnet: {
      //provider: () => new HDWalletProvider(secrets.seed, `https://bsc-dataseed1.binance.org`),
      //provider: () => new HDWalletProvider(secrets.seed, `https://bsc-dataseed1.defibit.io/`),
      //provider: () => new HDWalletProvider(secrets.seed, `https://data-seed-prebsc-2-s3.binance.org:8545/`, 0, 56),
      provider() {
        return new HDWalletProvider(secrets.seed,
           `https://data-seed-prebsc-2-s3.binance.org:8545/`, 0, 56)
      },
      network_id: 56,
      gas: 6300000,
      confirmations: 4,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    rsk: {
      provider() {
        return new HDWalletProvider('receive nasty...',
            'https://public-node.rsk.co', 0, 31)
      },
      network_id: 30,
      gasPrice: 100000000,
      skipDryRun: true,
      networkCheckTimeout: 1e9
    },
  },
  mocha: {
    reporter: 'eth-gas-reporter',
    reporterOptions: {
      currency: 'USD'
    }
  },
  compilers: {
    solc: {
      version: '0.5.16',
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
}
