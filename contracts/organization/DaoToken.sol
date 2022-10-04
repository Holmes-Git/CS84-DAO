// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../../node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "../../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

import "../AccessUtils.sol";

contract DaoToken is AccessUtils, ERC20, ERC20Permit {
    
    string internal constant TokenName = "OrgToken";
    string internal constant TokenSymbol = "OGT";



    constructor(address daoAccessControlAddress) ERC20(TokenName, TokenSymbol) ERC20Permit(TokenName) {
        initializeAccessControl(daoAccessControlAddress);
        _mint(getAdmin(), 100 * 10 ** decimals());
    }


    function mint(address to, uint256 amount) public allowPermission(ADMIN) {
        
        _mint(to, amount);
    }


}
