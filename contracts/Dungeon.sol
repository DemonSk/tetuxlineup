// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract Dungeon {
    string public name;
    address public _owner;

    constructor(
        string memory _name,
        address _owner
    ) public {
        name = _name;
        _owner = msg.sender;
    }

}