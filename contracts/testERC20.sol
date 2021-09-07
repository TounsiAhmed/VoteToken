// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract VoteToken is ERC721, Ownable {
//this is a constructor
  constructor() ERC721("VoteToken", "VOT")  {
    _mint(msg.sender, 5000000*(10**18));
  }

}