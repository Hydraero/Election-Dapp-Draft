pragma solidity ^0.8.12;
contract Election {
    
    struct Candidate {
        uint candidateID;
        string candidateName;
        uint voteCount;
    }

    struct Voter {
        bool authorized;                                //check if voter/user is authorized
        bool voted;                                     //check if voter/user has voted
        uint vote;                                      //checks who voters voted for
    }

    address public owner;                               //owner of the contract
    string public electionName;             

    mapping(address => Voter) public voters;            //keeps track of voters
    mapping(uint => Candidate) public candidatesMap;    //stores/keeps track candidates
    Candidate[] public candidates;                      //array of candidates to be voted for
    uint public totalVotes;                             //Stores total votes
    uint public candidatesCount;                        //Stores candidates count

    modifier ownerOnly() {                              //modifier to allow owner only functionalities (used in functions)
        require(msg.sender == owner);
        _;                                              //executes everything in the function if requirement (is owner) is met;         
    }
    
    //smart contract constructor
    constructor(string[] memory candidateNames){
        owner = msg.sender;
        voters[owner].authorized = true;

        for (uint i = 0; i<candidateNames.length; i++){
            candidates.push(Candidate({
                candidateID: i,
                candidateName: candidateNames[i],
                voteCount:0
            }));
        }
    }
    //temporary addCandidate function
    function addCandidate(string memory _name) public {
        candidatesCount ++;
        candidates.push(Candidate(candidatesCount, _name, 0));
        candidatesMap[candidatesCount] = Candidate(candidatesCount, _name, 0);           //Update later
    }

    //Function to authorize voter, only election owners allowed
    function authorizeVoter(address voter) ownerOnly external {
        voters[voter].authorized = true;
    }

    //Function to deauthorize voter, only election owners allowed
    function deauthorizeVoter(address voter) ownerOnly external {
        voters[voter].authorized = false;
    }

    //Voting function
    function vote(uint _candidateID) public {
        require(!voters[msg.sender].voted, "Voter has already voted");                      // requires user to have not voted yet
        require(voters[msg.sender].authorized, "Voter is not authorized to vote");          // requires voter to be authorized

        voters[msg.sender].vote = _candidateID;
        voters[msg.sender].voted = true;                                                    //marks the voter as already having voted

        candidatesMap[_candidateID].voteCount ++;
        totalVotes ++;
    }

}