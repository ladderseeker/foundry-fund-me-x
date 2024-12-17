# Solidity Ccourse - Foundry Fund Me

# Intorduction

This is the Solidity && Foundry follow-alone course project of [Cyfrin Updraft](https://updraft.cyfrin.io/), with a basic FundMe contract with deployment script, test and quick start. 

The FundMe contract are deployed on Sepolia testnet, the address is [0x2aA2EB143CeFdcA339F4dB030FC6CC516ceEE028](https://sepolia.etherscan.io/address/0x2aa2eb143cefdca339f4db030fc6cc516ceee028).

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [foundry](https://getfoundry.sh/)
  
```shell
foundryup

forge --version
# forge 0.2.0 (206dab2 2024-12-16T00:25:12.607328550Z)
```

## Quickstart

```
git clone https://github.com/ladderseeker/foundry-fund-me-x.git
cd foundry-fund-me-x
make
```

# Usage

## Deploy

- Local

```shell
# Start anvil locally
anvil
```

```shell
make deploy
```

```shell
# Or
forge script script/DeployFundMe.s.sol
```

- Sepolia

```shell
# Before execute, configure the ${ACCOUNT}, ${SEPOLIA_RPC_URL}, ${ETHERSCAN_API_KEY} in .env file by import wallet (see below), e.g. ACCOUNT=test-key

make deploy-sepolia ARGS="--network sepolia"
```

## Testing

```shell
make test
```

```shell
forge test --match-test xxx-method --fork-url ${SEPOLIA_RPC_URL}
```

## Interaction

```shell
make fund
```

```shell
make withdraw
```

# Addition

## Impot wallet
```
# import
cast wallet import ${your-account-name} --interactive

# usage
forge script <script> --rpc-url <rpc_url> --account <account_name> --sender <address> --broadcast
```
