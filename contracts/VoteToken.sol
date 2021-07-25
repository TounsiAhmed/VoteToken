// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract VoteToken is ERC20, Ownable {
//this is a constructor
  constructor() ERC20("VoteToken", "VOT")  {
    _mint(msg.sender, 5000000*(10**18));
  }

}