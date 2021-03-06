pragma solidity ^0.4.24;

import "./Interfaces.sol";

contract LifeMember is IERC1261 {

    //mapping (address => address) private _lifeMembers;
    address[] private _lifeMembers;

    uint256 public fee;

    function isCurrentMember(address _to) external view returns (bool) {
        for (uint i = 0; i < _lifeMembers.length; i++) {
            if (_lifeMembers[i] == _to) {
                return true;
            }
        }

        return false;
    }

    function getAllMembers() external view returns (address[]) {
        return _lifeMembers;
    }

    function getCurrentMemberCount() external view returns (uint) {
        return _lifeMembers.length;
    }

    function requestMembership(uint[] data) external payable {

    }

    /// @notice User can forfeit his membership.
    /// @dev Throws if the `msg.sender` already doesn't have the token.
    ///  The individual `msg.sender` can revoke his/her membership.
    ///  When the token is revoked, this function emits the Revoked event.
    function forfeitMembership() external payable {

    }

    function approveRequest(address _user) external onlyBoardMembers() {

    }

    function assignTo(address _to, uint[] data) external onlyBoardMembers() {
        _lifeMembers.push(_to);
    }


    event Assigned(address indexed to);
    event Revoked(address indexed to);
    event ModifiedData(address indexed to);

    modifier onlyBoardMembers() {
        _;
    }
}