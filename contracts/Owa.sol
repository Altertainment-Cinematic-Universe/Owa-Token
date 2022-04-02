// SPDX-License-Identifier: MIT

pragma solidity 0.8.6;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Owa is ERC20Burnable, Ownable {
    event Recovered(
        address admin,
        address indexed token,
        address indexed to,
        uint256 amount
    );

    constructor() Ownable() ERC20("Owa", "OWA") {
        _mint(msg.sender, 1e27);
        transferOwnership(msg.sender);
    }

    function recoverToken(
        address token,
        address to,
        uint256 amount
    ) external onlyOwner {
        IERC20 token_ = IERC20(token);
        require(
            token_.balanceOf(address(this)) >= amount,
            "Insufficient balance"
        );

        token_.transfer(to, amount);
        emit Recovered(msg.sender, token, to, amount);
    }
}
