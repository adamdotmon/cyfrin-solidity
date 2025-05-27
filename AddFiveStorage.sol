// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.30; 

import {SimpleStorage} from "./SimpleStorage.sol";

// inheritance and overriding
contract AddFiveStorage is SimpleStorage{
    // virtual override
    // if virtual keyword is not added to store() in SimpleStorage, it is not overridable (inheritable). 
    function store(uint256 _favNumber) public override {
        favNumber = _favNumber + 5;
    }
}