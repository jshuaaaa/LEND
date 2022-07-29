// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract lEth is ERC20, Ownable {
    constructor(
    ) ERC20("LendETH", "lETH") {}
  

    function redeemFromLendingPool(uint amount) internal {
        _burn(msg.sender, amount);
    }

    function mintFromLendingPool(uint amount, address sender) public  payable {
        _mint(sender, amount);
    }
}