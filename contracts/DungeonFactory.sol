// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./Dungeon.sol";
import "./openzeppelin/SafeERC20.sol";
import "./openzeppelin/Ownable.sol";

contract DungeonFactory is Ownable {
    using SafeERC20 for IERC20;

    IERC20 public buyToken;
    uint256 public buyTokenAmount;

    Dungeon[] public DungeonAddresses;

    constructor(IERC20 _buyToken, uint256 _buyTokenAmount) {
        buyToken = _buyToken;
        buyTokenAmount = _buyTokenAmount;
    }

    function createDungeon(string memory name, uint256[] memory _arr) public {
        buyToken.safeTransferFrom(msg.sender, address(this), buyTokenAmount);
        Dungeon DungeonAddress = new Dungeon(name, _arr);
        DungeonAddresses.push(DungeonAddress);
    }

    function setBuyToken(IERC20 _buyToken) external onlyOwner {
        buyToken = _buyToken;
    }

    function setbuyTokenAmount(uint256 _buyTokenAmount) external onlyOwner {
        buyTokenAmount = _buyTokenAmount;
    }

    function setBuyTokenAndPrice(IERC20 _buyToken, uint256 _buyTokenAmount)
        external
        onlyOwner
    {
        buyToken = _buyToken;
        buyTokenAmount = _buyTokenAmount;
    }
}
