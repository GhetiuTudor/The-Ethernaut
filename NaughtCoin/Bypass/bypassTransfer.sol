//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface INC{
    function approve(address, uint) external returns(bool);
    function transferFrom(address, address, uint) external returns(bool);
    function balanceOf(address) external view returns(uint);
}

contract Bypass{
    INC token; //the token contract implementation
    address EOA; // the address of my external wallet containing the funds

    constructor(address tokenAddr, address mm){
        token = INC(tokenAddr);
        EOA = mm;
    }

    function bypass() external {
        //making the transfer after being approved to do so 
        token.transferFrom(EOA,address(this),token.balanceOf(EOA));
    }

}
