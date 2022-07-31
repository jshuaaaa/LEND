// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.3;
import "./LethToken.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./LendToken.sol";

contract LendingPool {
    uint stakingTimeTracker;

    constructor(){
        stakingTimeTracker = block.timestamp;
    }

    address owner = msg.sender;
   
    mapping(address => uint) _balances;
    mapping(address => uint) _borrowAmount;
    mapping(address => bool) isStaked;
    mapping(address => uint) hasStakedSince;
    
    lEth public lETH;
    address wEth = 0xc778417E063141139Fce010982780140Aa0cD5Ab; 



    function deposit(uint _amount, address LendETH) public payable {
        _balances[msg.sender] += _amount;
        isStaked[msg.sender] = true;
        hasStakedSince[msg.sender] = block.timestamp;
        lEth(LendETH).mint(_amount, msg.sender);
        ERC20(address(wEth)).transferFrom(msg.sender, address(this), _amount);
    }
    

    function withdraw(uint _amount, address LendETH) public payable {
        // Takes the amount of lEth is in the wallet and sets it equal to _balances, leading lEth to be a tokenized form of collateral
        _balances[msg.sender] = lEth(LendETH).balanceOf(msg.sender);
        require(_balances[msg.sender] >= _amount);
        _balances[msg.sender] -= _amount;
        
        if(_balances[msg.sender] == 0) {
        isStaked[msg.sender] = false;
        hasStakedSince[msg.sender] = 0;
        }
        
        ERC20(wEth).transfer(msg.sender, _amount);
        lEth(LendETH).redeem(msg.sender, _amount);
    }


    function borrow(uint _amount) public payable {
        require(_amount <=  _balances[msg.sender] * 70/100);
        require(_borrowAmount[msg.sender] <=  _balances[msg.sender] * 70/100);
        _borrowAmount[msg.sender] += _amount;
        ERC20(wEth).transfer(msg.sender, _amount);
    }

    function repayBorrow(uint _amount) public payable {
        require(_borrowAmount[msg.sender] >= _amount);
        require(_borrowAmount[msg.sender] > 0);
        _borrowAmount[msg.sender] -= _amount;
        ERC20(wEth).transferFrom(msg.sender, address(this), _amount);

    }

    function claimReward(address LendAddress) public {
        require(_balances[msg.sender] > 0);
        require(hasStakedSince[msg.sender] > 0);
        uint rewardsOwed = (hasStakedSince[msg.sender] - block.timestamp);
        rewardsOwed = rewardsOwed * 10 ** 9;
        rewardsOwed = rewardsOwed + (_balances[msg.sender] * 10);

        // Incentivizes users to borrow by increasing the LEND token they get    
        if(_borrowAmount[msg.sender] >= _balances[msg.sender] * 50/100 ) {
            rewardsOwed = rewardsOwed * 130/100;
        }

        // Every 4 weeks rewards emitted gets cut in half
        if(block.timestamp >= stakingTimeTracker + 4 weeks) {
            rewardsOwed = rewardsOwed/2;
            stakingTimeTracker += 4 weeks; 
        } 

        LendToken(LendAddress).claim(rewardsOwed, msg.sender);


    }
}