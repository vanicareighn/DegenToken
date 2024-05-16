// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "./ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(uint256 => uint256) public itemPrices;

    event ItemRedeemed(address indexed player, uint256 indexed itemId, uint256 amount);

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
        itemPrices[1] = 200; // Item 1: Potion - Price: 200 tokens
        itemPrices[2] = 400; // Item 2: Super Potion - Price: 400 tokens
        itemPrices[3] = 1000; // Item 3: Hyper Potion - Price: 1000 tokens
        itemPrices[4] = 2000; // Item 4: Full Restore - Price: 2000 tokens
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function setItemPrice(uint256 itemId, uint256 price) external onlyOwner {
        itemPrices[itemId] = price;
    }

    function redeemItem(uint256 itemId) external {
        // Ensure item price is set and player has enough balance
        require(itemPrices[itemId] > 0, "Item price not set");
        require(balanceOf(msg.sender) >= itemPrices[itemId], "Insufficient balance");

        // Transfer tokens from player to owner (in-game store)
        _transfer(msg.sender, owner, itemPrices[itemId]);
        emit ItemRedeemed(msg.sender, itemId, itemPrices[itemId]);
    }
}