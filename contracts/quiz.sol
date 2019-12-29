pragma solidity ^0.5.11;

contract quiz {

    address public owner;
    uint public endTime;

    enum Status {
        unknown, alive, missing
    }
    Status public statusNow;
    constructor() public
        {
            owner = msg.sender;
            statusNow = Status.unknown;
            endTime = now + 90 seconds;
        }
    modifier isOwner(){
        require(msg.sender == owner, "Invalid Authentication");
        _;
    }

    function setStatus(string memory inputData) public isOwner(){
        if(keccak256(abi.encodePacked(inputData)) == keccak256(abi.encodePacked("I am alive")) ){
            statusNow = Status.alive;
            endTime = now + 90 seconds;
        }
        else if(now >= endTime)
        {
            statusNow = Status.missing;
        }
    }

    function getStatus() public view returns(string memory){
        if(now >= endTime){return "Missing";}
        else if(Status.unknown == statusNow){return "Unknown";}
        else if(Status.alive == statusNow){return "Alive";}
    }
}