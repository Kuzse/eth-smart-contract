// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 private storedData;
    event DataUpdated(uint256 oldValue, uint256 newValue, address indexed updater);

    constructor(uint256 _initValue) {
        storedData = _initValue;
    }

    function set(uint256 _value) external {
        uint256 old = storedData;
        storedData = _value;
        emit DataUpdated(old, _value, msg.sender);
    }

    function get() external view returns (uint256) {
        return storedData;
    }
}
