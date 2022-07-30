import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Lendingpool.sol";

contract LendToken is ERC20,Ownable {
    constructor(
    ) ERC20("LEND", "LEND") {
        _mint(msg.sender, 100000);
    }
    
    
    function claim(uint amount, address sender) external {
        _mint(sender, amount);
    }
}