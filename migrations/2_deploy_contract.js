const Hero = artifacts.require("Hero");
const DungeonFactory = artifacts.require("DungeonFactory");

module.exports = function (deployer) {
  deployer.deploy(Hero);
  deployer.deploy(DungeonFactory);
};
