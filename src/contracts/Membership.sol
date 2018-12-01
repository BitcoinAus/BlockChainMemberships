pragma solidity ^0.4.24;

contract Membership {
    address private _owner;

    string public name = "Blockchain Australia";
    uint16 public totalMembers;

    //in finney
    uint256 public annual = 20 finney;
    uint256 public life = 200 finney;

    mapping(address => Member) public members;

    enum MembershipLevel {
        Annual,
        Life,
        Board,
        ExBoard
    }

    struct Member {
        uint256 issued;
        uint256 validFrom;
        uint256 expires;
        MembershipLevel level;
    }

    constructor() public {
        _owner = msg.sender;
    }

    function addAnnualMember(address _member) public onlyBoard() {
        require(_member != 0x00, "Invalid address");

        members[_member] = Member(now, now, now + 1 years, 0);
        totalMembers += 1;

        emit NewMember(_member);
    }

    function buyAnnualMembership() public payable {
        require(msg.value > annual, "Fee too small");

        uint256 expires = now + 1 years;

        members[msg.sender] = Member(now, now, expires, 1);
        totalMembers += 1;

        emit NewMember(msg.sender);
    }

    function isAnnualMember(address who) external view returns (bool) {
        return members[who].level == MembershipLevel.Annual;
    }

    function addLifeMember(address _member) public onlyBoard() {
        require(_member != address(0), "Invalid address");

        members[_member] = Member(now, now, now + 1000 years, 1);
        totalMembers += 1;

        emit NewMember(_member);
    }

    function isLifeMember(address who) external view returns (bool) {
        return members[who].level == MembershipLevel.Life;
    }

    function buyLifeMembership() public payable {
        require(msg.value > annual, "Fee too small");

        uint256 expires = now + 1000 years;

        members[msg.sender] = Member(now, now, expires, 2);
        totalMembers += 1;

        emit NewMember(msg.sender);
    }

    function addBoardMember(address _member) public onlyBoard() {
        require(_member != address(0), "Invalid address");

        members[_member] = Member(now, now, now + 1000 years, 2);
        totalMembers += 1;

        emit NewMember(_member);
    }

    function isBoardMember(address who) external view returns (bool) {
        return members[who].level == MembershipLevel.Board;
    }

    function retire() public onlyBoard() {
        //retire from the board
    }

    function revokeMember(address _member) public onlyBoard() {
        delete members[_member];
        totalMembers -= 1;
    }

    function isCurrentMember(address to) public view returns (bool) {
        return members[to].validFrom > now && members[to].expires < now;
    }


    function setLifeFee(uint256 _value) public onlyBoard() {
        life = _value;
    }

    function setAnnualFee(uint256 value) public onlyBoard() {
        annual = value;
        emit FeeUpdated(value);
    }

    function withdraw(address to) public onlyBoard() {
        
    }

    event NewMember(address _member);
    event FeeUpdated(uint256 value);

    modifier onlyOwner() {
        require(msg.sender == _owner);

        _;
    }

    modifier onlyBoard() {

    }

}