// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "../src/HelperConfig.sol";

contract FundMeDeploy is Script {
    function run() external returns (FundMe) {
        // Start broadcasting transactions
        FundMe fundMe;
        vm.startBroadcast();
        
        // Create a new instance of HelperConfig
        HelperConfig helperConfig = new HelperConfig();
        
        // Get the address of the price feed from the helper config
        //address priceFeed = helperConfig.activeNetworkConfig();
        
        // Deploy the FundMe contract with the price feed address
         fundMe = new FundMe(helperConfig.activeNetworkConfig());
        
        // Stop broadcasting transactions
        vm.stopBroadcast();
        
        return fundMe;
    }
}
