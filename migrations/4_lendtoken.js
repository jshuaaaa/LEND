const Migrations = artifacts.require("LendToken");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
