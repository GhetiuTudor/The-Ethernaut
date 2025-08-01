//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ForcedTransfer{

constructor() payable{}

//a contract with no defined payable function of fallback method is not able to receive ether

function force(address payable a) public {

    //however there is a bypass available for that 
    //the selfdestruct() will forcefully transfer the entire balance of this contract to an address
    //regardless of the address type

    selfdestruct(a);

    // before the cancun hard fork this opcode used to also destroy the data and code 
    // associated with the contract
}

function getBalance() public view returns(uint){
    return address(this).balance; 
}

}
