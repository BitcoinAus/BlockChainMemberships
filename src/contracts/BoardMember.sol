pragma solidity ^0.4.24;

contract Membership {
    address private _owner;

    string public name = "Blockchain Australia Board Member";
    uint16 public totalMembers;

    mapping(address => Member) public members;
    mapping(address => address) public nominations;

    struct Member {
        uint256 issued;
    }

    struct Request {

    }

    constructor() public {
        _owner = msg.sender;
    }

    function nominate(address who) public onlyBoard() {
        require(who != address(0), "Invalid address");

        members[who] = Member(now, now, now + 1 years, 0);
        totalMembers += 1;

        emit NewMember(who);
    }

    function selfNominate(address _member) public {
        require(_member != 0x00, "Invalid address");

        members[_member] = Member(now, now, now + 1 years, 0);
        totalMembers += 1;

        emit NewMember(_member);
    }

    function isMember(address who) external view returns (bool) {
        return (!members[who] == address(0));
    }

    function retire() public {
        //retire from the board
        delete members[msg.sender];
    }

    function revokeMember(address who) public onlyBoard() {
        delete members[_member];
        totalMembers -= 1;
    }

    event NewMember(address _member);
    event FeeUpdated(uint256 value);

    function () external {
        revert("Fall back function");
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "This function can only be performed by the contract owner");

        _;
    }

    modifier onlyBoard() {
        require(isBoardMember(msg.sender), "This function can only be performed by a board member");
        _;
    }
}