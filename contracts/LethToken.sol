pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract lEth is ERC20 {
    constructor() ERC20("LendETH", "lETH") {}
    address LendingPoolContract;

    function transferToLendingPool(address _to, uint AmountDeposited) public payable {
        require(_to == LendingPoolContract);
        AmountDeposited = msg.value;
        _mint(msg.sender, AmountDeposited);
    }
}