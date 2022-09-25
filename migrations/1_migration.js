// Help Truffle find `TruffleTutorial.sol` in the `/contracts` directory

const OrgToken = artifacts.require('OrgToken');
const MyOrg = artifacts.require('MyOrg');
const Admin = artifacts.require('Admin');

module.exports = async function (deployer) {
  // Command Truffle to deploy the Smart Contract
  await deployer.deploy(Admin);
  await deployer.deploy(OrgToken);
  const token = await OrgToken.deployed();
  await deployer.deploy(MyOrg, OrgToken.address);
  const org = MyOrg.deployed();
  await deployer.deploy(Admin);
};
