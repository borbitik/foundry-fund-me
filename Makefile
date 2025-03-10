# Load environment variables from .env file
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

# Build the project
build:
	forge build

# Run tests
test:
	forge test

# Format the code
fmt:
	forge fmt

# Take gas snapshots
snapshot:
	forge snapshot

# Start Anvil (local Ethereum node)
anvil:
	anvil

# Deploy the contract
deploy-sepolia:
	forge script scripts/FundMeDeploy.s.sol:FundMeDeploy --rpc-url $(SEPOLIA_RPC_URL) --account account1 --broadcast --verify $(ETHERSCAN_API_KEY)


# Fund the contract
fund-sepolia:
	forge script scripts/Interaction.s.sol:FundFundMe --rpc-url $(SEPOLIA_RPC_URL) --account account1 --broadcast

# Withdraw from the contract
withdraw-sepolia:
	forge script scripts/Interaction.s.sol:WithdrawFundMe --rpc-url $(SEPOLIA_RPC_URL) --account account1 --broadcast

help:
	@echo "build: Build the project"
	@echo "test: Run tests"
	@echo "fmt: Format the code"
	@echo "snapshot: Take gas snapshots"
	@echo "anvil: Start Anvil (local Ethereum node)"
	@echo "deploy-sepolia: Deploy the contract"
	@echo "fund-sepolia: Fund the contract"
	@echo "withdraw-sepolia: Withdraw from the contract"
	@echo "help: Show this help message" 