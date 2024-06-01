//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test,console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract MoodNftIntegrationTest is Test{
    DeployMoodNft deployer;
    MoodNft moodnft;
    address public USER = makeAddr("user");
    function setUp()external{
        deployer = new DeployMoodNft();
        moodnft = deployer.run();
    }
    function testViewTokenUriIntegration()public{
        vm.prank(USER);
        moodnft.mintNft();
        console.log(moodnft.tokenURI(0));
    }
    function testFlipMoodtoSad()public{
        vm.prank(USER);
        moodnft.mintNft();
        vm.prank(USER);
        moodnft.flipMood(0);
        assert(MoodNft.Mood.SAD == moodnft.getMoodofUser(0));
    }
}