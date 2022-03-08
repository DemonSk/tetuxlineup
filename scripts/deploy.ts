// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.

//npx hardhat run --network rinkeby scripts/deploy.ts
//npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"

import { ethers } from "hardhat";
const hre = require("hardhat");

const goerliToken = "0x24C9184c7DA6CA2F3B5cF55E646E9CD581b89dA7";
const goerliTokenAmount = "10000";

async function main() {
  const Hero = await ethers.getContractFactory("Hero");
  const hero = await Hero.deploy(goerliToken, goerliTokenAmount);
  await hero.deployed();

  const Factory = await ethers.getContractFactory("DungeonFactory");
  const factory = await Factory.deploy(goerliToken, goerliTokenAmount);
  await factory.deployed();

  console.log("Hero deployed to:", hero.address);
  console.log("Factory deployed to:", factory.address);

  console.log("Wait 60 seconds for network sync");
  await new Promise((resolve) => setTimeout(resolve, 60000)); // pause for Etherscan update

  try {
    await hre.run("verify:verify", {
      address: hero.address,
      constructorArguments: [goerliToken, goerliTokenAmount],
      contract: "contracts/Hero.sol:Hero",
    });
    await hre.run("verify:verify", {
      address: factory.address,
      constructorArguments: [goerliToken, goerliTokenAmount],
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
