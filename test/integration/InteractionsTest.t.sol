// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract InteractionsTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant SEND_VALUE = 1 ether;

    function setUp() external {
        console.log("Setting up FundMeTest");
        fundMe = new DeployFundMe().run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundAndOwnerWithdraw() public {
        uint256 preUserBalance = address(USER).balance;
        uint256 preOwnerBalance = address(fundMe.getOwner()).balance;

        // Using vm.prank to simulate funding from the USER address
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        uint256 afterUserBalance = address(USER).balance;
        uint256 afterOwnerBalance = address(fundMe.getOwner()).balance;

        assert(address(fundMe).balance == 0);
        assertEq(afterUserBalance + SEND_VALUE, preUserBalance);
        assertEq(preOwnerBalance + SEND_VALUE, afterOwnerBalance);
    }

    // function testUserCanFundAndOwnerCanWithDraw() public {
    //     address contractOwner = fundMe.getOwner();
    //     console.log("Owner address: ", address(contractOwner));

    //     address fundMeAddress = address(fundMe);
    //     console.log("FundMe address: ", fundMeAddress);

    //     // Check contract balance
    //     uint256 preContractBalance = address(fundMe).balance;
    //     console.log("Pre Contract balance: ", preContractBalance);

    //     // Check Owner balance
    //     uint256 preOwnerBalance = address(contractOwner).balance;
    //     console.log("Pre Owner balance: ", preOwnerBalance);

    //     FundFundMe fundFundMe = new FundFundMe();
    //     fundFundMe.fundFundMe(address(fundMe));

    //     // Check contract balance after fund
    //     uint256 afterContractBalance = address(fundMe).balance;
    //     console.log("Contract balance after fund: ", afterContractBalance);

    //     // Check Owner balance after fund
    //     uint256 afterOwnerBlance = address(contractOwner).balance;
    //     console.log("Owner balance after fund: ", afterOwnerBlance);

    //     // Check gap between the two balance
    //     uint256 gap = preOwnerBalance - afterOwnerBlance;
    //     console.log("Gap between owner balance before and after fund: ", gap);

    //     WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
    //     withdrawFundMe.withdrawFundMe(address(fundMe));

    //     // Check contract balance after withdraw
    //     uint256 afterWithdrawContractBalance = address(fundMe).balance;
    //     console.log(
    //         "Contract balance after withdraw: ",
    //         afterWithdrawContractBalance
    //     );

    //     // Check Owner balance after withdraw
    //     uint256 afterWithdrawOwnerBlance = address(contractOwner).balance;
    //     console.log("Owner balance after withdraw: ", afterWithdrawOwnerBlance);

    //     assert(address(fundMe).balance == 0);
    //     assertEq(
    //         afterWithdrawOwnerBlance,
    //         preOwnerBalance + preContractBalance
    //     );
    // }
}
