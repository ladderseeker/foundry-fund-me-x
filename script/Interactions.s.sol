// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {
    uint256 SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        FundMe fundMe = FundMe(payable(mostRecentlyDeploy));
        fundMe.fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(mostRecentlyDeploy);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        FundMe fundMe = FundMe(payable(mostRecentlyDeploy));
        fundMe.withdraw();
        vm.stopBroadcast();
        console.log("Withdraw FundMe balance!");
    }

    function run() external {
        address mostRecentlyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(mostRecentlyDeploy);
    }
}
