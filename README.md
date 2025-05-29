# Voting Smart Contract

This is a simple voting system written in Solidity.This voting system is time-bound and the contract allows a chairperson to register voters, add proposals, set a voting window, and let the registered voters vote during a specific time frame only. The final winner is the one with maximum votes.

---

## Features provided:

- Chairperson can register voters, proposals, and set voting timespan.
- Unauthorized access and double voting is not allowed.
- Results are transparently tracked on-chain.
- Emits events for voter registration and vote casting(events act like a log entry tied to an actual on-chain change).
- BONUS FEATURE :: Time-restricted voting period.
- BONUS FEATURE :: The winner is the one with highest vote count.

---

## Contract Overview

### Chairperson

The contract deployer becomes the chairperson. Only he/she is allowed to :

- Register voters
- Add proposals
- Set the voting period




---
### Workflow chart with different functions used and their purpose:
#### 1. Contract Deployment
- The deployer becomes the **chairperson**.
- Defines when voting can start and end (based on `block.timestamp`).
- This is handled via the contract constructor.


#### 2. Chairperson Registers Voters
- Chairperson calls-> `registerVoter(address voter)`
- Adds voters who are allowed to participate.



#### 3. Chairperson Adds Proposals
- Chairperson calls-> `addProposal(string memory _name)`
- Each proposal is stored with a unique ID and initialized vote count.


#### 4. Voters Cast Their Vote
- Registered voters call-> `vote(uint proposalId)`

   ##### ~Conditions:
- Must be a registered voter
- Must not have voted already
- Must vote within the specified time period

   ##### ~Updates on Vote:
- Marks voter as voted.
- Increments selected proposal’s vote count.



#### 5. Get the Winner
- Call `getWinner()`(anyone can call this function)
- Returns the proposal with maximum votes.



---
### Voter structure

The following struct is used to keep track of each voter:

```solidity
struct Voter {
    bool is_registered;//checks if voter is registered
    bool has_voted;//keeps track if the voter has cast their vote
    uint voted_PID;//this is the proposal ID the voter has opted
}
```
---
## Resources:


1. Resources given in the assignment material itself. 
2. For general information about Solidity: https://solidity-by-example.org/ .
3. For Solidity syntax: https://youtu.be/RQzuQb0dfBM?feature=shared and some use of AI.
4. For information about Ethereum and other terms(and application): https://youtu.be/mfSr-c9sAjI?feature=shared .

---
### -Namish Shankar Srivastava
- CSE(B.Tech.)
- 24075101

