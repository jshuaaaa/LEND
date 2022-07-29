const Migrations = artifacts.require("LendingPool");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
