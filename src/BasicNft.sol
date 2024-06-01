//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";

contract BasicNft is ERC721{
    uint256 private s_tokencounter;
    mapping(uint256 => string) private s_tokenIdtoURI;

    constructor()ERC721("Dogie","DOG"){
        s_tokencounter = 0;
    }

    function mintNft(string memory tokenUri)public{
        s_tokenIdtoURI[s_tokencounter] = tokenUri;
        _safeMint(msg.sender,s_tokencounter);
        s_tokencounter++;
    }

    function tokenURI(uint256 tokenId)public view override returns(string memory){
        return s_tokenIdtoURI[tokenId];
    }
}