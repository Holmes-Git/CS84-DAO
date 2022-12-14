// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// contract DaoAccessControlInherit {
//     function inquiryAddressPermission(bytes32 permission,address account) 
//         public 
//         view 
//         returns(bool);
// }

import "./IDaoAccessControlInherit.sol";


contract DaoRecord {

    bytes32 private constant riskLevelLow = keccak256(abi.encode("low"));
    bytes32 private constant riskLevelModerate = keccak256(abi.encode("moderate"));
    bytes32 private constant riskLevelHigh = keccak256(abi.encode("high"));
    bytes32 private constant riskLevelExtreme = keccak256(abi.encode("extreme"));

    event LowRisk(string lowRiskOutput);
    event ModerateRisk(string moderateRiskOutput);
    event HighRisk(string highRiskOutput);
    event ExtremeRisk(string extremeRiskOutput);

    bytes32 internal constant STAFF_ROLE = keccak256("STAFF_ROLE");


    address private constant daoAccessControlAddress = 0x0E48A7EC9D78D0eF015A453098C3Be6B6a796F0D;
    IDaoAccessControlInherit public daoAccessControlInherit = IDaoAccessControlInherit(daoAccessControlAddress);


    modifier allowStaff() {
        bool ifallow = daoAccessControlInherit.inquiryAddressPermission(STAFF_ROLE, msg.sender);
        require(ifallow);
        _;
    }

    function recordNPV() public {

    }

    function recordRisk(string memory riskLevel) public allowStaff{
        bytes32 userRiskLevel = keccak256(abi.encode(riskLevel));
        if (userRiskLevel == riskLevelLow) {
            emit LowRisk("The risk level is low.");
        }
        else if (userRiskLevel == riskLevelModerate) {
            emit ModerateRisk("The risk level is moderate.");
        }
        else if (userRiskLevel == riskLevelHigh) {
            emit HighRisk("The risk level is high. Start checking procedure...");
        }
        else if (userRiskLevel == riskLevelExtreme) {
            emit ExtremeRisk("The risk level is extreme. Start checking procedure...");
        }
        else {
            revert("Record: input wrong.");
        }
    }

}