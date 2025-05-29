// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.30; 

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        // makes more gas efficient, but only if you are sure the numbers you use will not ever hit a overflow 
        unchecked {bigNumber = bigNumber + 1;}
    }
}