//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script{
    MoodNft moodnft;
    function run()external returns(MoodNft){
        string memory happysvg = vm.readFile("./img/happy.svg");
        string memory sadsvg = vm.readFile("./img/sad.svg");
        vm.startBroadcast();
        moodnft = new MoodNft(svgtoImageUri(happysvg),svgtoImageUri(sadsvg));
        vm.stopBroadcast();
        return moodnft;
    }
    function svgtoImageUri(string memory svg)public pure returns(string memory){
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }
}