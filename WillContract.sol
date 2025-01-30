//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Will{
    address owner;
    address recipient;
    uint lastVisited;
    uint oneYear;
    uint startTime;

    constructor( address _recipient){
        owner = msg.sender;
        recipient = _recipient;
        oneYear = 24 hours * 365 days;
    }

    modifier onlyOwner(){
        require (msg.sender == owner);
        _;
    }
    modifier onlyRecipient(){
        require(msg.sender == recipient);
        _;
    }

    function deposit( ) public payable onlyOwner(){
        lastVisited = block.timestamp;
    }
    function ping() public onlyOwner {
        lastVisited = block.timestamp;
        
    }
    function claim () public payable onlyRecipient {
        require(lastVisited > block.timestamp - oneYear, "you are not the recipient");
        payable(recipient).transfer(address(this).balance);
    }
}