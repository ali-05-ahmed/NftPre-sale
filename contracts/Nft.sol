// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract Nft is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 public totalSupply;

    mapping(address=>bool) private _public;
    mapping(address=>bool) private legendry;
    mapping(address=>bool) private WhiteListed;



    constructor() ERC721("ELU", "ELU") {
    totalSupply = 7000;
    }

    function createToken(string memory tokenURI) private returns (uint) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }

    function Buy() public payable returns(bool) {
        uint256 current = Counters.current(_tokenIds);
        uint256 price;
        require(current < totalSupply ,"All the Sold");
        require(isWitelisted(msg.sender) == false ,"Already bought");
        if(current < 500 ){
            price = 0.04 ether ; 
        require(msg.value == price , "please send 0.04 ethers");
        legendry[msg.sender]=true;
        createToken("YourNft.com");
        return true;
        }
        else if(current >= 500 && current < 1500  ){
            price = 0.06 ether ; 
        require(msg.value == price , "please send 0.06 ethers");
        WhiteListed[msg.sender]=true;
        createToken("YourNft.com");
        return true;
        }
        else if(current >= 1500){
            price = 0.08 ether ; 
        require(msg.value == price , "please send 0.08 ethers");
        _public[msg.sender]=true;
        createToken("YourNft.com");
        return true;
        }
    }

    function isWitelisted(address account)public returns(bool){
        if(_public[account]){
            return true;
        }
        else if(WhiteListed[account]){
            return true;
        }
        else if(legendry[account]){
            return true;
        }
        else{
            return false;
        }       
    }

    //returns the total number of Nfts minted from this contract
    function currentSupply() public view returns(uint256){
        return _tokenIds.current();
    }

    function getTime() private view returns(uint256){
        return block.timestamp;
    }
}