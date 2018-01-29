pragma solidity 0.4.18;

contract Membership {
    address private _owner;

    string public name = "Blockchain Australia";
    uint16 public totalMembers;

    uint256 public ethaud = 1;

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
        //string twitter;
        bytes32 id;
    }

    function Membership() public {
        _owner = msg.sender;
    }

    function addMember(string _id, uint256 _expires, address _member) public onlyOwner {
        require(_expires > now);
        require(_member != 0x00);

        members[_member] = Member(now, now, _expires, keccak256(_id));

        NewMember(_member);
    }

    function revokeMember(address _member) public onlyOwner {
        delete members[_member];
    }

    function buyMembership() public payable {
        require(msg.value > 1 ether);

        members[msg.sender] = Member(now, now, 253370764800, keccak256(_id));
    }

    function isValid(address _member) public view returns (bool) {
        return members[_member].validFrom > now && members[_member].expires < now;
    }

    event NewMember(address _member);

    modifier onlyOwner() {
        require(msg.sender == _owner);

        _;
    }
}
