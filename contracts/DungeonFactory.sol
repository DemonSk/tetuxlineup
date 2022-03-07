// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./Dungeon.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DungeonFactory is Ownable{
    using SafeERC20 for IERC20;

    IERC20 public buyToken;
    uint256 public buyTokenPrice;
    
    Dungeon[] public DungeonAddresses;
    
    function createDungeon(string memory name) public{
        buyToken.safeTransferFrom(msg.sender, address(this), buyTokenPrice);
        Dungeon DungeonAddress = new Dungeon(name, msg.sender);
        DungeonAddresses.push(DungeonAddress);   
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