pragma solidity ^0.5.11;

contract quiz {

    string public inputData;
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
        }
    modifier isOwner(){
        require(msg.sender == owner, "Invalid Authentication");
        _;
    }

    function getInput(string memory statusKey) public isOwner() {
        inputData = statusKey;
    }
        function storageState() public isOwner(){
        if(keccak256(abi.encodePacked(inputData)) == keccak256(abi.encodePacked("I am alive")) ){
            statusNow = Status.alive;
        }
    }
    function setTimer() public {
        endTime = now + 60 seconds;
    }
    function isEnd() public isOwner(){
        if(now >= endTime){
            statusNow = Status.missing;
        }
    }
    function getStatus() public view returns(string memory){
        if(Status.unknown == statusNow){ return "Unknown";}
        if(Status.missing == statusNow){ return "Missing";}
        if(Status.alive == statusNow){ return "Alive";}
    }
}