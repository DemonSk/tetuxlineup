// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./openzeppelin/ERC721.sol";
import "./openzeppelin/ERC721Burnable.sol";
import "./openzeppelin/SafeERC20.sol";
import "./openzeppelin/Ownable.sol";

contract Hero is ERC721, ERC721Burnable, Ownable {
    using SafeERC20 for IERC20;

    IERC20 public buyToken;
    uint256 public buyTokenAmount;

    uint256 public nextHero;

    struct Hero {
        address minter;
        string className;
        uint8 classId;
        uint256 xp;
        uint256 level;
        uint256 health;
        uint256 damage;
        bool isAlive;
    }
    Hero[] public heroes;

    constructor() ERC721("Hero", "HR") {}

    function recruit(uint8 _class) external {
        require(1 <= _class && _class <= 2);
        buyToken.safeTransferFrom(msg.sender, address(this), buyTokenAmount);
        uint256 _nextHero = nextHero;
        if (_class == 1) {
            heroes.push(
                Hero(msg.sender, "Assassin", _class, 0, 1, 150e18, 11e18, true)
            );
        } else if (_class == 2) {
            heroes.push(
                Hero(msg.sender, "Mage", _class, 0, 1, 100e18, 16e18, true)
            );
        }
        _safeMint(_msgSender(), _nextHero);
        nextHero++;
    }

    function xp_required(uint256 curent_level)
        public
        pure
        returns (uint256 xp_to_next_level)
    {
        xp_to_next_level = curent_level * 1000e18;
        for (uint256 i = 1; i < curent_level; i++) {
            xp_to_next_level += i * 1000e18;
        }
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

    function withdrawFunds(
        IERC20 token,
        address receiver,
        uint256 amount
    ) external onlyOwner {
        token.safeTransfer(receiver, amount);
    }

    function withdrawAllFunds(IERC20 token, address receiver)
        external
        onlyOwner
    {
        uint256 tokenBalance = token.balanceOf(address(this));

        token.safeTransfer(receiver, tokenBalance);
    }
}
