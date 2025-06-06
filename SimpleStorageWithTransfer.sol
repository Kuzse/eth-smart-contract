// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorageWithTransfer {
    uint256 private storedData;
    event DataUpdated(uint256 oldValue, uint256 newValue, address indexed updater);
    event EtherTransferred(address indexed from, address indexed to, uint256 amount);

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

    receive() external payable {
        // accept ETH
    }

    fallback() external payable {
        // accept calls with ETH and unknown calldata
    }

    function pay(address payable _to) external payable {
        uint256 amount = msg.value;
        require(amount > 0, "No ETH to send");
        (bool success, ) = _to.call{value: amount}("");
        require(success, "Transfer failed");
        emit EtherTransferred(msg.sender, _to, amount);
    }

    function sendFromContract(address payable _to, uint256 _amount) external {
        require(address(this).balance >= _amount, "Not enough ETH");
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed");
        emit EtherTransferred(address(this), _to, _amount);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
