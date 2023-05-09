// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract koi {
    // use for exclusive items function 
    struct ExclusiveItem {
        uint256 price;
        bool isAvailable;
        address owner; // Add owner member to struct
    }

    mapping(uint256 => ExclusiveItem) private exclusiveItems;
    uint256 public itemSold;

    // minimum ether sent requirement
    uint256 public mintRate = 0.00 ether; 

    // maximum supply
    uint public maxSupply = 50; 
    // state varaible that updates in the database 
    uint public amountItem = 0;     // datatype: unsigned interger (always positive)
    uint public limitedEditionSupply = 10; // Initialize the limited edition supply variable

    // state variables
    address public owner;
    mapping (address => uint) public accBalances;
    //---------------------------------------------------------------------------------------------
    // set the initial balance to 5
    constructor() {
        owner = msg.sender;
        accBalances[address(this)] = 5;
    }
    //---------------------------------------------------------------------------------------------
    function initializeContract() public {
        owner = msg.sender;
        accBalances[address(this)] = 5;
    }
    //---------------------------------------------------------------------------------------------
    function getKoiBalance() public view returns (uint) {
        return accBalances[address(this)];
    }
    //---------------------------------------------------------------------------------------------
    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock.");
        accBalances[address(this)] += amount;
    }
    //---------------------------------------------------------------------------------------------
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 0.00000001 ether, "You must pay at least 0.00000001 ETH per donut");
        require(accBalances[address(this)] >= amount, "Not enough donuts in stock to complete this purchase");
        accBalances[address(this)] -= amount;
        accBalances[msg.sender] += amount;
    }
    //---------------------------------------------------------------------------------------------
    // A function to check the balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }   
}