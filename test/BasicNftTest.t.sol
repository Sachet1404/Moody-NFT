//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test,console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test{
    address public USER = makeAddr("user");
    uint256 public constant STARTING_BALANCE = 10 ether;
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    BasicNft public basicnft;
    function setUp()external{
        DeployBasicNft deployer = new DeployBasicNft();
        basicnft = deployer.run();
        
    }
    function testNameisCorrect()public view{
        string memory expectedname = "Dogie";
        string memory actualname = basicnft.name();
        assert(keccak256(abi.encodePacked(expectedname)) == keccak256(abi.encodePacked(actualname)));
    }
    function testCanMintandHaveaBalance()public{
        vm.prank(USER);
        basicnft.mintNft(PUG);
        assert(basicnft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(basicnft.tokenURI(0))) == keccak256(abi.encodePacked(PUG)));
    }
}