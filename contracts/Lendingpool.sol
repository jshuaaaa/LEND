// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.3;
import "./LethToken.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LendingPool {
    address owner = msg.sender;
    mapping(address => uint) _balances;
    lEth public lETH;
    address wEth = 0xc778417E063141139Fce010982780140Aa0cD5Ab;

    function approval(uint _amount) public {
        ERC20(wEth).approve(address(this), _amount);
    }

    function deposit(uint _amount) public payable {
        _balances[msg.sender] += _amount;
        approval(_amount);
        lETH.mint(_amount, msg.sender);
        ERC20(wEth).transferFrom(msg.sender, address(this), _amount);
    }
    

    function withdraw(uint _amount) public payable {
        require(_balances[msg.sender] >= _amount);
        _balances[msg.sender] -= _amount;
        ERC20(wEth).transfer(msg.sender, _amount);
        lETH.redeem(msg.sender, _amount);
    }

}