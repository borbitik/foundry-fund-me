# Foundry Fund Me

## Overview
This project deploys and tests a simple crowdfunding smart contract using Foundry. It includes:
- A deploy script that broadcasts transactions.
- A Solidity contract (FundMe) that accepts funding and allows the owner to withdraw funds.
- A test suite covering various functionalities of the contract.

## Setup
- Install Foundry: Follow the instructions at [Foundry Book](https://book.getfoundry.sh/)
- Clone the repository and navigate to the project directory.
- Run `forge install` to install dependencies.
- Update the price feed address in `FundMeDeploy.s.sol` if needed.

## Deployment
Deploy the contract using the deploy script:
```bash
forge script script/FundMeDeploy.s.sol --broadcast --verify
```
*Note: Ensure your environment variables are set for network configuration.*

## Testing
Run the tests with:
```bash
forge test
```
This will execute the tests defined in `test/FundMeTest.t.sol`.

## Additional Info
- The contract uses Chainlink's Aggregator for price feeds.
- The deploy script currently hardcodes the price feed address; configuration can be improved using a dedicated helper config contract.
- For further guidance, refer to the tutorial by Patrick Collins on Foundry.

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/FundMeDeploy.s.sol:FundMeDeployScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Deploy with private key stored using Cast

```shell
# ⚠️ IMPORTANT: Store Private Key
Store the private key securely outside of VS Code to prevent accidental exposure in version control or text editor history.
$ cast wallet import deployer --interactive
Enter private key:

# Deploy using stored key
$ forge script script/FundMeDeploy.s.sol:FundMeDeployScript --rpc-url <your_rpc_url> --account deployer
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
