// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;
import "./Dungeon.sol";
import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DungeonFactory is Ownable {
  using SafeERC20 for IERC20;

  IERC20 public buyToken;
  uint256 public buyTokenPrice;

  address public libraryAddress;

  event DungeonCreated(address newDungeon);

  function DungeonFactory(address _libraryAddress) external {
    libraryAddress = _libraryAddress;
  }

  function setLibraryAddress(address _libraryAddress) external onlyOwner {
    libraryAddress = _libraryAddress;
  }

  function createDungeon(string memory _name) external {
    buyToken.safeTransferFrom(msg.sender, address(this), buyTokenPrice);
    address clone = Clones.clone(libraryAddress);
    Dungeon(clone).initialize(_name);
    DungeonCreated(clone);
  }

  function setBuyToken(IERC20 _buyToken) external onlyOwner  {
    buyToken = _buyToken;
  }

  function setBuyTokenPrice(uint256 _buyTokenPrice) external onlyOwner  {
    buyTokenPrice = _buyTokenPrice;
  }

  function setBuyTokenAndPrice(IERC20 _buyToken, uint256 _buyTokenPrice) external onlyOwner  {
    buyToken = _buyToken;
    buyTokenPrice = _buyTokenPrice;
  }
}