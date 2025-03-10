// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

import {MockV3Aggregator} from "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract HelperConfig is Script{
    uint256 private constant SEPOLIA_CHAIN_ID = 11155111;
    uint256 private constant ANVIL_CHAIN_ID = 31337;
    uint256 private constant MAINNET_CHAIN_ID = 1;
    uint8 private constant DECIMALS = 8;
    int256 private constant INITIAL_PRICE = 2e8;

    NetWorkConfig public activeNetworkConfig;

    struct NetWorkConfig {
        address priceFeed; //ETH/USD price feed adress
    }

    constructor() {
        if (block.chainid == SEPOLIA_CHAIN_ID) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == MAINNET_CHAIN_ID) {
            activeNetworkConfig = getMainnet();
        }else{
            activeNetworkConfig = getOrCreateAnvil();
        }
         activeNetworkConfig = getOrCreateAnvil();
    }

    function getSepoliaEthConfig() private pure returns (NetWorkConfig memory) {
        NetWorkConfig  memory ethconfig =  NetWorkConfig(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return ethconfig;
    }
    function getMainnet() private pure returns (NetWorkConfig memory) {
        NetWorkConfig memory ethConfig =  NetWorkConfig(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        return ethConfig;
    }

    function getOrCreateAnvil() private returns (NetWorkConfig memory){

        if( address(activeNetworkConfig.priceFeed) != address(0)){
            return activeNetworkConfig;
        }

        vm.startBroadcast();
        MockV3Aggregator mock = new MockV3Aggregator(DECIMALS,INITIAL_PRICE);
    
        vm.stopBroadcast();

        NetWorkConfig memory ethConfig = NetWorkConfig(address(mock));
        return ethConfig;   
          
    }
}
