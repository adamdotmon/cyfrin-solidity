// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.30; 
// comment

contract SimpleStorage {
    // uint256 favNumber; init as 0 by default
    // internal = private
    uint256 favNumber;
    // uint256[] listOfFavNumbers; // [1, 2, 3, 4]
    struct Person {
        uint256 myFavNumber;
        string name;
    }

    // Person public adam = Person({myFavNumber: 7, name: "Adam"});
    // dynamic array, size of array can grow or shrink
    Person[] public peopleList;
    // Person[3] public peopleList; static array up to 3 elements 

    // mapping = dictionary, provide a key to output value
    mapping(string => uint256) public nameToFavNumber;

    function store(uint256 _favNumber) public virtual {
        favNumber = _favNumber;
        retrieve();
    }
    // view, pure : if another contract calls functions that 
    // view = read state from blockchain, disallow updating state
    function retrieve() public view returns (uint256) { 
        return favNumber;
    }
    // calldata (temp var cannot be modified), 
    // memory (temp var can be modified), uint256 is primitive type, string is array of bytes so needs memory or calldata keyword
    // storage (perma var that can be modified) 
    function addPerson(string memory _name, uint256 _favNumber) public {
        peopleList.push(Person(_favNumber, _name));
        // allow person object to be fetched by name, returning favourite number
        nameToFavNumber[_name] = _favNumber;
    }
}