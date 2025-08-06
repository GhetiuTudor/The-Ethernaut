//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

interface IMagicNum {
    function solver() external view returns (address);
    function setSolver(address) external;
}

interface ISolver {
    function whatIsTheMeaningOfLife() external view returns (uint256);
}

//I had to create a contract that will return 42 on every call and is no longer than 10 bytes
//to do that i had to write the bytecode for the opcodes needed to write 42 to a 32 byte 
//memory slot and then return the value of that memory slot

contract SetSolver {
    constructor(IMagicNum target) {
        
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        //this is the resulted bytecode, created with evm.codes
        address solver;
        assembly {
            // create(value, offset, size) 
            //value - amount of ether sent to the contract

            //offset - the offset at which the bytecode starts -> bytecode points to the beginning of the string
            //but at the beginning of the string the length is written in a 32 byte word (0x20 in hexadecimal)
            //to get to the bytecode I had to add the size of the length value to the general pointer

            //size - the size of the bytecode is 19 - 0x13 in hexa
            solver := create(0, add(bytecode, 0x20), 0x13)
        }
        //require(addr != address(0));

        target.setSolver(solver);
    }
}
