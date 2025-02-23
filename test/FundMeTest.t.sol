//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test,console} from "forge-std/Test.sol";

import {FundMe} from "../src/FundMe.sol";
import {FundMeDeploy} from "../scripts/FundMeDeploy.s.sol";


contract FundMeTest is Test {

    FundMe fundMe;

    function setUp() public {
        console.log("Setting up");
        fundMe = new FundMeDeploy().run();
    }

    function testMinimimDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsDeployer() public view {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testGetVersion() public view {
        assertEq(fundMe.getVersion(), 4);
    }
}
