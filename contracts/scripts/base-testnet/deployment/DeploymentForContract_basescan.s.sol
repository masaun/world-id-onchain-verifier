pragma solidity ^0.8.17;

import "forge-std/Script.sol";

/// @dev - The Solidity On-chain Verifier, which is generated via NoirJS/bb.js
import { IWorldID } from '../../../src/interfaces/IWorldID.sol';
import { Contract } from "../../../src/Contract.sol";

/**
 * @notice - Deployment script to deploy all SCs at once - on BASE Testnet
 */
contract DeploymentForContract_basescan is Script {
    Contract public contractInstance;
    IWorldID public worldIdRouterInstance;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("base_testnet");  // [NOTE]: foundry.toml - BASE Testnet RPC URL
        //vm.createSelectFork("hhttps://sepolia.base.org");
        
        uint256 deployerPrivateKey = vm.envUint("BASE_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //vm.startBroadcast();

        // @dev - Constructor params
        // constructor(IWorldID _worldId, string memory _appId, string memory _actionId) {}
        address WORLD_ID_ROUTER = vm.envAddress("WORLD_ID_ROUTER_ON_BASE_TESTNET"); // World ID Router SC on Base Testnet
        string memory APP_ID = vm.envString("NEXT_PUBLIC_APP_ID");                  // App ID
        string memory ACTION_ID = vm.envString("NEXT_PUBLIC_ACTION");               // Action ID

        worldIdRouterInstance = IWorldID(WORLD_ID_ROUTER);

        /// @dev - Deploy the SCs
        //contractInstance = Contract(vm.envAddress("CONTRACT_ON_BASE_TESTNET"));
        contractInstance = new Contract(worldIdRouterInstance, APP_ID, ACTION_ID);
        
         /// @dev - Set the deployed SC address to .env file
        vm.stopBroadcast();

        /// @dev - Logs of the deployed-contracts on Base Mainnet
        console.logString("Logs of the deployed-contracts on Base Testnet");
        console.logString("\n");
        console.log("%s: %s", "Contract SC", address(contractInstance));
    }
}