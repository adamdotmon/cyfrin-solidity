// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.30; 

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public listOfSimpleStorageContracts;
    // address[] public listOfSimpleStorageAddresses

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newsimpleStorageNumber) public {
        // Address
        // ABI - APplication Binary Interface
        listOfSimpleStorageContracts[_simpleStorageIndex].store(_newsimpleStorageNumber);
        // type casting example, SimpleStorage(address)
        // SimpleStorage mySimpleStorage = SimpleStorage(listOfSimpleStorageAddresses[_simpleStorageIndex]);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}