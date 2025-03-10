// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "../src/HelperConfig.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMeDeploy is Script {
    function run() external returns (FundMe) {
        // Start broadcasting transactions
        FundMe fundMe;
        // Create a new instance of HelperConfig
        HelperConfig helperConfig = new HelperConfig();

        address pricefeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();

        fundMe = new FundMe(pricefeed);

        vm.stopBroadcast();

        return fundMe;
    }
}
