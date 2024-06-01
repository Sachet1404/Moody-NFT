//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script{
    BasicNft basicnft;
    function run()external returns(BasicNft){
        vm.startBroadcast();
        basicnft = new BasicNft();
        vm.stopBroadcast();
        return basicnft;
    }
}