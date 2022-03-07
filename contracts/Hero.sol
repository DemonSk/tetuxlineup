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

    uint public next_hero;
    mapping(uint => address) public minters;
    mapping(uint => uint) public xp;
    mapping(uint => uint) public class_id;
    mapping(uint => uint) public level;
    mapping(uint => uint) public health;
    mapping(uint => uint) public damage; 
    mapping(uint => bool) public is_alive;    

    constructor() ERC721("Hero", "HR") {}

    function recruit(uint _class) external {
        require(1 <= _class && _class <= 2);
        buyToken.safeTransferFrom(msg.sender, address(this), buyTokenAmount);
        uint _next_hero = next_hero;
        class_id[_next_hero] = _class;
        level[_next_hero] = 1;
        minters[_next_hero] = _msgSender(); 
        is_alive[_next_hero] = true;
        if (_class == 1) {
            health[_next_hero] = 150e18;
            damage[_next_hero] = 11e18;
        } else if (_class == 2) {
            health[_next_hero] = 100e18;
            damage[_next_hero] = 16e18;
        }
        _safeMint(_msgSender(), _next_hero);
        next_hero++;
    }

    function xp_required(uint curent_level) public pure returns (uint xp_to_next_level) {
        xp_to_next_level = curent_level * 1000e18;
        for (uint i = 1; i < curent_level; i++) {
            xp_to_next_level += i * 1000e18;
        }
    }
    function hero_info(uint _hero) external view returns (uint _xp, uint _health, uint _damage, uint _class, uint _level, bool _is_alive) {
        _xp = xp[_hero];
        _health = health[_hero];
        _damage = damage[_hero];
        _class = class_id[_hero];
        _level = level[_hero];
        _is_alive = is_alive[_hero];
    }

      function setBuyToken(IERC20 _buyToken) external onlyOwner  {
    buyToken = _buyToken;
  }

  function setbuyTokenAmount(uint256 _buyTokenAmount) external onlyOwner  {
    buyTokenAmount = _buyTokenAmount;
  }

  function setBuyTokenAndPrice(IERC20 _buyToken, uint256 _buyTokenAmount) external onlyOwner  {
    buyToken = _buyToken;
    buyTokenAmount = _buyTokenAmount;
  }
}