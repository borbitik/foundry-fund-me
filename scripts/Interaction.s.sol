// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {
    uint256 public constant SENDER_INITIAL = 0.0023 ether;

    function fundfundme(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        console.log("before fund");
        FundMe(payable(mostRecentlyDeploy)).fund{value: SENDER_INITIAL}();
        vm.stopBroadcast();
        console.log("Funded FundMe contract with %s", SENDER_INITIAL);
    }

    function run() external {
        address mostRecent = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );

        console.log("Most recent deployment address:", mostRecent);
       
        fundfundme(mostRecent);

    }
}

contract WithdrawFundMe is Script {

    function withdrawfundme(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeploy)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecent = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawfundme(mostRecent);

    }
   

}
