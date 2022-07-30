// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.3;
import "./LethToken.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LendingPool {
    address owner = msg.sender;
    mapping(address => uint) _balances;
    mapping(address => uint) _borrowAmount;
    lEth public lETH;
    address wEth = 0xc778417E063141139Fce010982780140Aa0cD5Ab;


    function deposit(uint _amount, address LendETH) public payable {
        _balances[msg.sender] += _amount;
        lEth(LendETH).mint(_amount, msg.sender);
        ERC20(address(wEth)).transferFrom(msg.sender, address(this), _amount);
    }
    

    function withdraw(uint _amount, address LendETH) public payable {
        require(_balances[msg.sender] >= _amount);
        _balances[msg.sender] -= _amount;
        ERC20(wEth).transfer(msg.sender, _amount);
        lEth(LendETH).redeem(msg.sender, _amount);
    }


    function borrow(uint _amount) public payable {
        require(_amount <=  _balances[msg.sender] * 70/100);
        _borrowAmount[msg.sender] += _amount;
        ERC20(wEth).transfer(msg.sender, _amount);
    }

    function repayBorrow(uint _amount) public payable {
        require(_borrowAmount[msg.sender] >= _amount);
        require(_borrowAmount[msg.sender] > 0);
        _borrowAmount[msg.sender] -= _amount;
        ERC20(wEth).transferFrom(msg.sender, address(this), _amount);

    }
}