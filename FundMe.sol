// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.30; 

import {PriceConverter} from "./PriceConverter.sol";
// 791204

error NotOwner();
contract FundMe {
    // use the library
    using PriceConverter for uint256;
    
    uint256 public constant MIN_USD = 1 * 1e18;
    
    // store array of funders on the contract to keep track 
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;

    }

    function fund() public payable {
        msg.value.getConversionRate();
        // getConversionRate() uses msg.value as first param because we shifted conversion to PriceConverter library
        // adding a param to getConversionRate() lib function means when we call it here we need to add the param getConversionRate(extra var)
        require(msg.value.getConversionRate() >= MIN_USD, "didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
        // during a revert
        // undo any actions that have been done and send the remaining gas back
        // gas is still spent in a reverted txn
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset array
        funders = new address[](0);
        // withdraw funds
        // msg.sender = address 
        // payable(msg.sender) = payable address, you can only work with payable address to send funds in solidity 
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // call (recommended way to call or receive eth in general), ABI not required
        (bool callSucccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucccess, "Call failed");
    }

    modifier onlyOwner(){
        // _; execute code inside function first
        // require(msg.sender == i_owner, "Sender is not Owner");
        if(msg.sender != i_owner) { revert NotOwner(); }
        // _; execute code before function first
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}