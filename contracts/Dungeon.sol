// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./Hero.sol";

contract Dungeon {
    string public name;
    address public creator;
    bool public inDungeon;

    event Enter(uint256 heroId, string dungeonName);

    modifier freeDungeon() {
        require(inDungeon != true, "Someone is in dungeon now");
        _;
    }

    constructor(string memory _name, address _creator) public {
        name = _name;
        creator = _creator;
    }

    function enter(uint256 heroId) external freeDungeon {
        inDungeon = true;
        emit Enter(heroId, name);
    }

    function damageHero(
        Hero heroContract,
        uint256 heroId,
        uint256 damage
    ) external {
        heroContract.removeHealth(heroId, damage);
    }
}
