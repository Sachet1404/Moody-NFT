//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
contract MoodNft is ERC721{

    error MoodNft_CantFlipMoodIfNotOwner();
    uint256 private s_tokencounter;
    string private s_happysvgImageUri;
    string private s_sadsvgImageUri;
    enum Mood{
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdtoMood;

    constructor(string memory happysvgImageUri,string memory sadsvgImageUri)ERC721("Mood Nft","MN"){
        s_happysvgImageUri = happysvgImageUri;
        s_sadsvgImageUri = sadsvgImageUri;
        s_tokencounter = 0;
    }
    function mintNft()public{
        _safeMint(msg.sender,s_tokencounter);
        s_tokenIdtoMood[s_tokencounter] = Mood.HAPPY;
        s_tokencounter++;
    }
    function flipMood(uint256 tokenId)public{
       if(!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId)){
        revert MoodNft_CantFlipMoodIfNotOwner();
       }
       if(s_tokenIdtoMood[tokenId] == Mood.HAPPY){
        s_tokenIdtoMood[tokenId] = Mood.SAD;
       }
       else{
        s_tokenIdtoMood[tokenId] = Mood.HAPPY;
       }
    }
    function _baseURI()internal pure override returns(string memory){
        return "data:application/json;base64,";
    }
    function tokenURI(uint256 tokenId)public view override returns(string memory){
        string memory imageUri;
        if(s_tokenIdtoMood[tokenId] == Mood.HAPPY){
            imageUri = s_happysvgImageUri;
        }
        else{
            imageUri = s_sadsvgImageUri;
        }
        return 
        string(
               abi.encodePacked(
               _baseURI(),
               Base64.encode(bytes(abi.encodePacked('{"name": "',name(),'","description": "An Nft that reflects the owners Mood","attributes":[{"trait_type": "Moodiness","value": "100"}],"image": "',imageUri,'"}')))
               )
            );
    }
    function getMoodofUser(uint256 tokenId)public view returns(Mood){
        return s_tokenIdtoMood[tokenId];
    }
}