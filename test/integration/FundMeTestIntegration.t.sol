// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {FundFundMe} from "../../scripts/Interaction.s.sol";
import {WithdrawFundMe} from "../../scripts/Interaction.s.sol";
import {FundMeDeploy} from "../../scripts/FundMeDeploy.s.sol";
import {FundMe} from "../../src/FundMe.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Script.sol";

contract FundMeTestIntegration is Test {
    FundMe private fundMe;

    address private USER = makeAddr("BOB");

    uint256 constant STARTING_BALANCE = 15 ether;

    function setUp() external {
        fundMe = new FundMeDeploy().run();
        // vm.deal(USER, STARTING_BALANCE);
    }

    function testCanFundMeInteraction() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundfundme(address(fundMe));
        assertEq(address(fundMe).balance, fundFundMe.SENDER_INITIAL());
 
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawfundme(address(fundMe));

        assertEq(address(fundMe).balance, 0);
       
    }
}
