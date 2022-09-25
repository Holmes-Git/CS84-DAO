// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract Admin is AccessControl {

    mapping (address => uint) public indexOfUser;
    address[] public userAccounts;
    uint public indexUser;
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        indexUser = 0;
    }

    function addUser(address _userAddress) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "This section is for Admin only");
        indexOfUser[_userAddress] = indexUser;
        userAccounts.push(_userAddress);
        indexUser++;
        grantRole(USER_ROLE, _userAddress);
    }

    function removeUser(address _userAddress) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "This section is for Admin only");
        delete userAccounts[indexOfUser[_userAddress]]; //delete address from userAccounts
        userAccounts[indexOfUser[_userAddress]] = userAccounts[userAccounts.length - 1]; //copy last item to the just deleted address
        indexOfUser[userAccounts[userAccounts.length - 1]] = indexOfUser[_userAddress];
        userAccounts.pop(); //remove the last item (same as the moved one)
        delete indexOfUser[_userAddress]; //delete user from mapping
        indexUser--;
        revokeRole(USER_ROLE, _userAddress);
    }

    function adminFunction() public view returns(string memory){
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender),"This section is for Admin only");
        string memory msg = "Admin Only";
        return msg;
    }

    function usersFunction() public view returns(string memory){
        require(hasRole(USER_ROLE, msg.sender),"This section is for Users only");
        string memory msg = "Users Only";
        return msg;
    }
}