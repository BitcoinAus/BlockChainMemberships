pragma solidity ^0.4.24;

contract BlockchainAustralia {

    address private lifeMembers = 0x00;
    address private boardMembers = 0x00;

    address private _owner;

    struct Level {
        address ContractAddress;
        string Name;
    }

    constrctor () public {
        _owner = msg.sender;
    }

    function isLifeMember(address who) external view returns (bool) {
        return members[who].level == MembershipLevel.Life;
    }
}