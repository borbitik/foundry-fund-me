//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";

import {FundMe} from "../../src/FundMe.sol";
import {FundMeDeploy} from "../../scripts/FundMeDeploy.s.sol";

contract FundMeTest is Test {
    FundMe public fundMe;

    address USER = makeAddr("BOB");

    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() public {
        fundMe = new FundMeDeploy().run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimimDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsDeployer() public {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testGetVersion() public {
        assertEq(fundMe.getVersion(), fundMe.aggregator().version());
    }

    function testRevertWhenNotMuchEth() public {
        vm.expectRevert();
        fundMe.fund(); // should revert since we don't send enough ETH
    }

    function testFundWithSuccess() public {
        uint256 expectedValue = 10e18;
        vm.prank(USER);
        fundMe.fund{value: expectedValue}();
        assertEq(fundMe.getAddressToAmountFunded(USER), expectedValue);
    }

    function testAddsFundertoArrayOfFunders() public funded {
        address funder = fundMe.getFunders(0);
        assertEq(funder, USER);
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithDrawWithSingleFunder() public funded {
        //given
        address owner = fundMe.getOwner();
        uint256 startingOwnerBalance = owner.balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        // when
        vm.prank(owner);
        fundMe.withdraw();

        //then
        uint256 endingOwnerBalance = owner.balance;
        uint256 endingContractBalance = address(fundMe).balance;

        assertEq(endingContractBalance, 0);

        assertEq(
            startingOwnerBalance + startingFundMeBalance,
            endingOwnerBalance
        );
    }

    function testWithDrawFromMultipleFunders() public funded {
        //Given
        uint160 numbersOfFunders =  10;
        for(uint160 i = 1; i < numbersOfFunders; i++){
             hoax(address(i), 10 ether);
             fundMe.fund{value: address(i).balance}();
        }

        address owner = fundMe.getOwner();
        uint256 startingOwnerBalance = owner.balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        //when
        vm.startPrank(owner);
        fundMe.withdraw();
        vm.stopPrank();

        //then
        uint256 endingOwnerBalance = owner.balance;
        uint256 endingContractBalance = address(fundMe).balance;
        console.log(endingOwnerBalance);
        assertEq(endingContractBalance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, endingOwnerBalance);


        
    }

        function testWithDrawFromMultipleFundersCheaper() public funded {
        //Given
        uint160 numbersOfFunders =  10;
        for(uint160 i = 1; i < numbersOfFunders; i++){
             hoax(address(i), 10 ether);
             fundMe.fund{value: address(i).balance}();
        }

        address owner = fundMe.getOwner();
        uint256 startingOwnerBalance = owner.balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        //when
        vm.startPrank(owner);
        fundMe.withdrawCheaper();
        vm.stopPrank();

        //then
        uint256 endingOwnerBalance = owner.balance;
        uint256 endingContractBalance = address(fundMe).balance;
        console.log(endingOwnerBalance);
        assertEq(endingContractBalance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, endingOwnerBalance);


        
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: 10 ether}();
        _;
    }
}
 