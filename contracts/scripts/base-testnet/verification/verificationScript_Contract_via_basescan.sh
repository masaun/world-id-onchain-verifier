# @notice - This script file must be run from the root directory of the project, where is the location of .env file.
echo "Load the environment variables from the .env file..."
source .env
#. ./.env

# @notice - [Result]: Successfully "verified" the Contract contract on Celo Mainnet. 
echo "Verifying the Contract contract on BASE Testnet (via BaseScan)..."
forge verify-contract \
    --rpc-url ${BASE_TESTNET_RPC} \
    --chain-id ${BASE_TESTNET_CHAIN_ID} \
    ${CONTRACT_ON_BASE_TESTNET} \
    src/Contract.sol:Contract \
    --etherscan-api-key ${BASESCAN_API_KEY}


echo "Verifying the Contract contract on BASE Testnet via Curl command..."
curl "https://api.basescan.org/api?module=contract&action=checkverifystatus&guid=${GUID}&apikey=${BASESCAN_API_KEY}"