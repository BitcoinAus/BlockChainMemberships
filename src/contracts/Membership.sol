pragma solidity ^0.4.18;

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
        ExBoard
    }

    struct Member {
        uint256 issued;
        uint256 validFrom;
        uint256 expires;
    }

    function Membership() public {
        _owner = msg.sender;
    }

    function addLifeMember(address _member) public onlyOwner {
        require(_member != 0x00);

        members[_member] = Member(now, now, now + 1000 years);

        NewMember(_member);
    }

    function addAnnualMember(address _member) public onlyOwner {
        require(_member != 0x00);

        members[_member] = Member(now, now, now + 1 years);

        NewMember(_member);
    }

    function revokeMember(address _member) public onlyOwner {
        delete members[_member];
    }

    function buyMembership() public payable {
        require(msg.value > annual);

        uint256 expires = now + 1 years;

        if (msg.value > 1 ether) {
            expires = now + 1000 years;
        }

        members[msg.sender] = Member(now, now, expires);
    }

    function isValid(address _member) public view returns (bool) {
        return members[_member].validFrom > now && members[_member].expires < now;
    }

    function setLifeFee(uint256 _value) public onlyOwner {
        life = _value;
    }

    function setAnnualFee(uint256 _value) public onlyOwner {
        annual = _value;
    }

    event NewMember(address _member);

    modifier onlyOwner() {
        require(msg.sender == _owner);

        _;
    }
}
