// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract VoteToken is ERC721, Ownable {
//this is a constructor
  constructor() ERC721("VoteToken", "VOT")  {
  }

    event AddedCandidate(uint candidateID);
    // describes a Voter, which has an id and the ID of the candidate they voted for
    

    
    struct Voter {
        uint vId;
        bytes32 uid; // bytes32 type are basically strings
        address uaddress;
        bool voted; //check if the voter voted  
    }
    // describes a Candidate
    struct Candidate {
        uint cId;
        bytes32 name;
        address caddress;
        // "bool doesExist" is to check if this Struct exists
        // This is so we can keep track of the candidates 
        bool doesExist; 
    }
    uint numCandidates=0; // declares a state variable - number Of Candidates
    uint numVoters=0;
    
    mapping (uint => Candidate) candidates;
    mapping (uint => Voter) voters;

    function addCandidate(bytes32 name,address caddress) public {
        // candidateID is the return variable
        uint candidateID = ++numCandidates;
        // Create new Candidate Struct with name and saves it to storage.
        candidates[candidateID] = Candidate(candidateID,name,caddress,true);
        emit AddedCandidate(candidateID);
    }
    function addVoter(bytes32 name,address vaddress) public{
        uint voterID = ++numVoters;
        voters[voterID]=Voter(voterID,name,vaddress,false);
        if (balanceOf(voters[voterID].uaddress)==0)
                _safeMint(voters[voterID].uaddress,voterID);
    }
    function getVoterId(address owner) public view returns(uint) {
        for (uint i = 1; i <= numVoters; ++i) {
            // if the voter votes for this specific candidate, we increment the number
            if (voters[i].uaddress == owner)
                return (i);
        }
        return (0);
    }
    
    modifier eligibleVoter(address _voter) {
        uint256 balance = balanceOf(_voter);
        require(balance > 0);
        require(getVoterId(_voter)>0);
        require(voters[getVoterId(_voter)].voted==false);
        _;
    }

    modifier trueCandidate(uint id) {
        require(id <= numCandidates);
        _;
    }
    
    
    function vote(uint id,address vaddress) eligibleVoter(vaddress) trueCandidate(id)  public{
        setApprovalForAll(vaddress, true);
        uint voterId=getVoterId(vaddress);
        transferFrom(vaddress, candidates[id].caddress , voterId);
        voters[voterId].voted==true;
    }

    function totalVotes(uint id) public trueCandidate(id) view returns(uint256){
        return (balanceOf(candidates[id].caddress));
    }

    function getwinner() public view returns (uint) {
        uint winnerID = 1;
        for (uint i = 1; i <= numCandidates; ++i) {
            // if the voter votes for this specific candidate, we increment the number
            if (totalVotes(i) > totalVotes(winnerID)) {
                winnerID=i;
            }
        }
        return winnerID;
    }

    function getNumOfCandidates() public view returns(uint) {
        return numCandidates;
    }

    function getNumOfVoters() public view returns(uint) {
        return numVoters;
    }
    function getCandidate(uint candidateID) public view returns (uint,bytes32,address) {
        return (candidateID,candidates[candidateID].name,candidates[candidateID].caddress);
    }
    function getVoter(uint voterId) public view returns (uint,bytes32,address) {
        return (voterId,voters[voterId].uid,voters[voterId].uaddress);
    }

}