// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.30; 

contract FallbackExample {
    uint256 public result;

    // used when calldata is empty and not used
    receive() external payable {
        result = 1;
    }

    // executed when calldata is not empty
    fallback() external payable {
        result = 2;
    }
}

// Ether is sent to contract
//      is msg.data empty?
//          /   \
//         yes  no
//         /     \
//    receive()?  fallback()
//     /   \
//   yes   no
//  /        \
//receive()  fallback()