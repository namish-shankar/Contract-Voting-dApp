// SPDX-License-Identifier: MIT
//SPDX-Software Package Data Exchange
pragma solidity ^ 0.8.0;
// (specifies solidity verison)
contract Voting
{
    address public chairperson;//address of chairperson (the deployer)

    //the deployer is set as the chairman
    constructor()
    {
        chairperson = msg.sender;
         vstart = block.timestamp;
        vend = block.timestamp + 604800;
    //set the voting period as [current timestamp, current timestamp + 1 week(604800) )
    }

    modifier onlyChairperson
    {
        require(msg.sender == chairperson, "Only chairperson can call this function");
        _; //acts as a placeholder for the function body to which the modifier is applied
    }
  
    uint public vstart;//start voting
    uint public vend;//end voting.       

    modifier onlyDuringVotingPeriod()
    {
        //require(condition,(what to return if condition is not satisfied));
        require(block.timestamp >= vstart, "WAIT FOR THE VOTING TO START!!");//error handling 1
        require(block.timestamp <= vend, "THE VOTING HAS ENDED!!");//error handling 2
        _;
    }

    //given structure for each voter
    struct Voter
    {
        bool is_registered;
        bool has_voted;
        uint voted_PID;
    } mapping(address => Voter) public voters;

    //func to register the voter with 'onlyChairperson' mofifier used so that only chairperson is allowed to register any voter
    function registerVoter(address voter) public onlyChairperson
    {
        require(!voters[voter].is_registered, "VOTER IS ALREADY REGISTERED!!");
        voters[voter].is_registered = true;
        emit voter_has_been_registered(voter);//emit event 
    }

    //structure for proposals-> with their names and vote counts for each
    struct Proposal
    {
        string name;
        uint vote_count;
    } Proposal[] public proposals;

    //to add proposal (can only be done by chairperson so modifier onlyChairperson is used)
    function addProposal(string memory _name) public onlyChairperson
    {
        proposals.push(Proposal({
            name : _name,
            vote_count : 0
        }));
    }

  
    //vote for a proposal only during the given period(onlyDuringVotingPeriod modifier is used)
    function vote(uint proposalId) public onlyDuringVotingPeriod
    {
        require(voters[msg.sender].is_registered, "VOTER NOT REGISTERED YET!!");//error handling 
        require(!voters[msg.sender].has_voted, "VOTER HAS ALREADY CAST THEIR VOTE!!");//error handling
        require(proposalId < proposals.length, "ENTER A VALID PROPOSAL ID!!");//error handling
        voters[msg.sender].has_voted = true;//set the voter's voting status as true
        voters[msg.sender].voted_PID = proposalId;//the proposal ID he has voted for
        proposals[proposalId].vote_count += 1;//increase the count for voted proposal ID 
        emit vote_has_been_cast(msg.sender, proposalId);//emit event
    }

    //to find the winner with their vote count
    function getWinner() public view returns(string memory final_winner, uint winner_vote_count)
    {
        uint winning_vote_count = 0;
        uint winner_index = 0;
        for (uint i = 0; i < proposals.length; i++)
        {
            if (proposals[i].vote_count > winning_vote_count)
            {
                winning_vote_count = proposals[i].vote_count;
                winner_index = i;
            }
        }
        //for loop used to find the candidate with maximum votes
        final_winner = proposals[winner_index].name;
        winner_vote_count = winning_vote_count;
    }

    //events
    event voter_has_been_registered(address voter);
    event vote_has_been_cast(address voter, uint proposalId);



}
/*
NAMISH SHANKAR SRIVASTAVA
CSE(B.Tech.)
24075101
*/
