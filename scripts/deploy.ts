// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.

//npx hardhat run --network rinkeby scripts/deploy.ts
//npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"

import { ethers } from "hardhat";
const hre = require("hardhat");

async function main() {
  const Hero = await ethers.getContractFactory("Hero");
  const Factory = await ethers.getContractFactory("DungeonFactory");
  const hero = await Hero.deploy();
  const factory = await Factory.deploy();

  await hero.deployed();
  await factory.deployed();

  console.log("Hero deployed to:", hero.address);
  console.log("Factory deployed to:", factory.address);

  console.log("Wait 60 seconds for network sync");
  await new Promise((resolve) => setTimeout(resolve, 60000)); // pause for Etherscan update

  try {
    await hre.run("verify:verify", {
      address: hero.address,
      // constructorArguments: [],
      contract: "contracts/Hero.sol:Hero",
    });
    await hre.run("verify:verify", {
      address: factory.address,
      // constructorArguments: [],
      contract: "contracts/DungeonFactory.sol:DungeonFactory",
    });
  } catch (err) {
    console.log(err);
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
