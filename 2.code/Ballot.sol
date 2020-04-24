pragma solidity ^0.5.17;
contract Ballot {
    struct Voter { //struct can't have default values
        int weight;
        int vote;
    }
    address chairman;
    mapping(address => Voter) voters; //gives voters[address]
    int[] proposals; //key gives proposal number, value gives votes

    constructor(uint proposalCount) public { //chairman initializes proposals
        chairman = msg.sender;
        voters[chairman].weight = 2; //chairman has double weightage
        voters[chairman].vote = -1;
        proposals.length = proposalCount;
    }

    function addvoter(address voterAddress) public {
        //only sender can add voter
        //voter should not have voted before
        if(
            msg.sender != chairman ||
            voters[voterAddress].vote == -1
            ) return;

        voters[voterAddress].weight = 1;
        voters[voterAddress].vote = -1;
    }

    function vote(uint proposalIndex) public {
        Voter storage sender = voters[msg.sender];

        if(
            sender.vote != -1 || //voter shouldn't have voted before
            proposalIndex < 0 ||
            proposalIndex >= proposals.length //index should be within bounds
            ) return;

        sender.vote = int(proposalIndex);
        proposals[proposalIndex] += sender.weight;
    }

    function winningProposal() public view returns (uint _winningProposal) {
        //return index with max value
        uint maxIndex = 3;
        for(uint index = 1; index < proposals.length; index++){
            if(proposals[index] > proposals[maxIndex]){
                maxIndex = index;
            }
        }
        _winningProposal = maxIndex;
    }
}