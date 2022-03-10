// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./Hero.sol";

contract Dungeon {
    string public name;
    address public creator;
    uint256 public heroInDungeon;
    bool public inDungeon;
    uint256[] public actions;
    uint8 public interactions;

    event Enter(uint256 heroId, string dungeonName);
    event Leave(uint256 heroId, string dungeonName);
    event Winner(uint256 heroId);

    constructor(string memory _name, uint256[] memory _actions) public {
        name = _name;
        actions = _actions;
        creator = msg.sender;
    }

    function enter(uint256 heroId) external {
        require(inDungeon != true, "Someone is in dungeon now");
        inDungeon = true;
        heroInDungeon = heroId;
        emit Enter(heroId, name);
    }

    function leave(uint256 heroId) external {
        require(heroInDungeon == heroId, "Your hero are not in Dungeon");
        inDungeon = false;
        heroInDungeon = 0;
        emit Leave(heroId, name);
    }

    function interaction(Hero heroContract, uint256 heroId) external {
        uint8 _interactions = interactions;
        uint256 action = actions[_interactions];
        if (action == 1) {
            heroContract.removeHealth(heroId, 50e18);
        } else if (action == 2) {
            heroContract.heal(heroId, 20e18);
        } else if (action == 3) {
            emit Winner(heroId);
        }
        interactions++;
    }
}
