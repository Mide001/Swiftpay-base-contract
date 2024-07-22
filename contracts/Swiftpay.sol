// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SwiftPay {
    address public owner;

    event SinglePayment(address indexed from, address indexed to, uint256 amount);
    event BatchPayment(address indexed from, address[] to, uint256[] amounts);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function singlePayment(address payable _to, uint256 _amount) external payable {
        require(msg.value == _amount, "Sent value must match the amount specified");
        _to.transfer(_amount);
        emit SinglePayment(msg.sender, _to, _amount);
    }

    function batchPayment(address payable[] calldata _to, uint256[] calldata _amounts) external payable {
        require(_to.length == _amounts.length, "Mismatch between address and amount array lengths");

        address[] memory _toMemory = new address[](_to.length);
    for (uint256 i = 0; i < _to.length; i++) {
        _toMemory[i] = _to[i];
    }
    

        uint256 totalAmount = 0;
        for (uint256 i = 0; i < _amounts.length; i++) {
            totalAmount += _amounts[i];
        }

        require(msg.value == totalAmount, "Sent value must match the total amount specified");

        for (uint256 i = 0; i < _to.length; i++) {
            _to[i].transfer(_amounts[i]);
        }

        emit BatchPayment(msg.sender, _toMemory, _amounts);
    }

    function withdraw(uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient contract balance");
        payable(owner).transfer(_amount);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}
