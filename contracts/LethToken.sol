// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract lEth is ERC20, Ownable {
    constructor(
    ) ERC20("LendETH", "lETH") {}
  

    function redeemFromLendingPool(address sender, uint amount) external {
        _burn(sender, amount);
    }

    function mintFromLendingPool(uint amount, address sender) external {
        _mint(sender, amount);
    }
}