pragma solidity ^0.4.24;

contract LifeMembership {
    address private _owner;

    string public name = "Blockchain Australia Life Member";
    uint16 public totalMembers;

    constructor() public {
        _owner = msg.sender;
    }
}