const VoteToken = artifacts.require("./VoteToken.sol");

const web3 = require("web3-utils");

module.exports = (deployer, network, [owner]) => {
  return deployer
    .then(() => deployer.deploy(VoteToken))
    .then(() => VoteToken.deployed())
};