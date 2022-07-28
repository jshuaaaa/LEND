const Migrations = artifacts.require("lEth");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
