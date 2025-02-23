// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";


contract HelperConfig is Script{
    uint256 public constant SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant ANVIL_CHAIN_ID = 31337;
    uint256 public constant MAINNET_CHAIN_ID = 1;

    NetWorkConfig public activeNetworkConfig;

    struct NetWorkConfig {
        address pricefeed; //ETH/USD price feed adress
    }

    constructor() {
        if (block.chainid == SEPOLIA_CHAIN_ID) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == MAINNET_CHAIN_ID) {
            activeNetworkConfig = getMainnet();
        }
    }

    function getSepoliaEthConfig() private pure returns (NetWorkConfig memory) {
        NetWorkConfig memory ethconfig =  NetWorkConfig(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return ethconfig;
    }
    function getMainnet() private pure returns (NetWorkConfig memory) {
        NetWorkConfig memory ethConfig =  NetWorkConfig(0x5f4ec3df9cbd43714fe2740f5e3616155c5b8419);
        return ethConfig;
    }

    function getOrCreateAnvil() private pure returns (NetWorkConfig memory){

        vm.startBroadcast()
        
          
    }
}
