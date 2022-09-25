// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "./Admin.sol";

contract OrgToken is ERC20, ERC20Burnable, ERC20Permit, ERC20Votes, Admin {

    Admin public admin;

    constructor() ERC20("OrgToken", "OGT") ERC20Permit("OrgToken") {
        _mint(msg.sender, 100 * 10 ** decimals());
        admin = new Admin();
    }

    function mint(address to, uint256 amount) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender),"Only admin can mint");
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._burn(account, amount);
    }
}