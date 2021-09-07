// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract VoteToken is ERC20, Ownable {
//this is a constructor
  constructor() ERC20("VoteToken", "VOT")  {
    _mint(msg.sender, 5000000*(10**18));
  }

    event AddedCandidate(uint candidateID);
    // describes a Voter, which has an id and the ID of the candidate they voted for
    address owner;
    function Voting()public {
        owner=msg.sender;
    }
    
    
    struct Voter {
        bytes32 uid; // bytes32 type are basically strings
        uint candidateIDVote;
        bool voted; //check if the voter voted  
    }
    // describes a Candidate
    struct Candidate {
        bytes32 name;
        // "bool doesExist" is to check if this Struct exists
        // This is so we can keep track of the candidates 
        bool doesExist; 
    }
    uint numCandidates; // declares a state variable - number Of Candidates
    uint numVoters;
    
    mapping (uint => Candidate) candidates;
    mapping (uint => Voter) voters;

    function addCandidate(bytes32 name) onlyOwner public {
        // candidateID is the return variable
        uint candidateID = numCandidates++;
        // Create new Candidate Struct with name and saves it to storage.
        candidates[candidateID] = Candidate(name,true);
        AddedCandidate(candidateID);
    }
    function submitVote(candidateID) public {
      
    }




}