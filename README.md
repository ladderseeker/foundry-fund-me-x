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

or

```shell
forge script script/DeployFundMe.s.sol
```

- Sepolia

```shell
# Before execute, configure the ${ACCOUNT}, ${SEPOLIA_RPC_URL}, ${ETHERSCAN_API_KEY} in .env file by import wallet (see below), e.g. ACCOUNT=test-key

make deploy-sepolia ARGS="--network sepolia"
```

or

```shell
forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --account $ACCOUNT --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

## Testing

```shell
make test
```

```shell
forge test --match-test ${method-name} --fork-url ${SEPOLIA_RPC_URL}
```

## Interactions

### Local

Start anvil by `anvil` and deploy locally `make deploy`

```shell
make fund
```

```shell
make withdraw
```

### Sepolia

- **Call view method**

```shell
cast call $SEPOLIA_CONTRACT_ADDRESS "getOwner()" --rpc-url $SEPOLIA_RPC_URL
```

```shell
cast call $SEPOLIA_CONTRACT_ADDRESS "getFunder(uint256)" 0 --rpc-url $SEPOLIA_RPC_URL
```

```shell
cast call $SEPOLIA_CONTRACT_ADDRESS "getAddressToAmountFunded(address)" $FUNDER_ADDRESS --rpc-url $SEPOLIA_RPC_URL
```

- **Call fund && wihtdraw**

```shell
cast send $SEPOLIA_CONTRACT_ADDRESS "fund()" --value 0.05ether --account $ACCOUNT

cast send $SEPOLIA_CONTRACT_ADDRESS "withdraw()"  --account $ACCOUNT
```

or

```shell
forge script script/Interactions.s.sol:FundFundMe --rpc-url $SEPOLIA_RPC_URL  --account $ACCOUNT  --broadcast

forge script script/Interactions.s.sol:WithdrawFundMe --rpc-url $SEPOLIA_RPC_URL --account $ACCOUNT --broadcast
```

# Additions

## Impot wallet

```
# import
cast wallet import ${your-account-name} --interactive

# usage
forge script <script> --rpc-url <rpc_url> --account <account_name> --sender <address> --broadcast
```

## Number convert

```shell
cast --to-base 0x01 dec
```

## Estimate gas

```shell
forge snapshot
```

## Formatting

```shell
forge fmt
```

## Test Coverage

```shell
forge coverage
```
