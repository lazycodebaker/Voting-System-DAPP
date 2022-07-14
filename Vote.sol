
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

contract Voting {

    struct Candidate { 
        uint id;
        string name;
        uint voteCount;
    }

    mapping (uint => Candidate) public candidates;
    uint public candidateCount = 0;
    mapping (address => bool) public voter;

    event VoteEvent(uint indexed _candidateID);

    constructor()  {
        AddCandidate("Typescript");
        AddCandidate("Javascript");
        AddCandidate("C++");
        AddCandidate("C#");
    }

    function AddCandidate(string memory _name) public {
        candidateCount += 1;
        candidates[candidateCount] = Candidate(
            candidateCount,_name,0
        );
    } 

    function Vote(uint _candidateID) public {
        require(!voter[msg.sender]);
        require(_candidateID > 0 && _candidateID <= candidateCount);

        voter[msg.sender] = true;
        candidates[_candidateID].voteCount += 1;

        emit VoteEvent(_candidateID);
    }
}
