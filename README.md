# DegenToken
ETH Intermediate Module 4 - Degen Token ERC20

## Description

The DegenToken smart contract is an ERC20 token designed for an in-game economy on the Ethereum blockchain. This contract allows the minting and burning of tokens, and it includes functionalities for setting prices for in-game items and redeeming those items using tokens. The contract demonstrates good error handling practices using the require statement to ensure proper conditions before executing critical functions. By implementing these functionalities, this contract provides useful lessons in building secure and reliable smart contracts for decentralized transactions in a gaming context.

## Executing the program

The first requirement to run this program is to use Remix Ethereum IDE (https://remix.ethereum.org/) and create a new files and take note that ".sol" is the correct file format for running a Solidity Program and compile the contract by selecting the appropriate Solidity compiler version (e.g., 0.8.0 or above) and clicking the "Compile DegenToken.sol" button.

To interact with the DegenToken contract and leverage its functionalities, you can use Remix Ethereum IDE. Begin by creating a new ".sol" file and compiling it using a Solidity compiler version 0.8.0 or above. The DegenToken contract, along with the Ownable.sol contract created alongside it, provide the necessary infrastructure for managing ownership and executing restricted functions. After compiling the contract, deploy it by selecting the Ethereum icon on the left sidebar. Once deployed, you can directly interact with its functions within the Remix IDE environment. The mint function facilitates token minting to a specified account, while the burn function allows burning tokens from the sender's account. Using the setItemPrice function, you can establish the price of items in the in-game store by specifying the item ID and the price in tokens. To redeem items from the in-game store, utilize the redeemItem function along with the corresponding item ID. Monitor the contract's behavior in the Remix IDE's "Console" tab, confirming successful function calls through emitted events.

Experiment with various inputs to understand how the contract handles scenarios such as insufficient balances or invalid item prices. Should any issues arise during contract interaction, utilize Remix IDE's debugger and console to inspect state changes and debug effectively.

```
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
```
## Additional Information

Student Info and Email address

Flores, John Nico M.
National Teachers College - BSIT 3.4
422003560@ntc.edu.ph
