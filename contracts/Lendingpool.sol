// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.3;
import "./LethToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


interface InterfacelETH {
    function _mint() external view returns (address, uint);

}

contract LendingPool {

    lEth public LendEth;

    function withdraw(address asset, uint amount, address onBehalfOf) public {
        require(onBehalfOf == msg.sender);
        LendEth.redeemFromLendingPool(onBehalfOf, amount);
        IERC20(asset).transferFrom(address(this), onBehalfOf, amount);
    }
    
    function deposit(address asset, uint amount, address onBehalfOf) public {
        require(onBehalfOf == msg.sender);
        IERC20(asset).transferFrom(msg.sender, address(this), amount);
        LendEth.mintFromLendingPool(amount, onBehalfOf);
        
    }
    function borrow() public {}
    function repayBorrow() public {}
}