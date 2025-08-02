// to call the unlock() fct succesfully I need the data[2] variable
/* 
This is the storage layout of Privacy contract

    bool public locked = true;
    uint256 public ID = block.timestamp;
    uint8 private flattening = 10;
    uint8 private denomination = 255;
    uint16 private awkwardness = uint16(block.timestamp);
    bytes32[3] private data;

    The EVM uses padding to save space where possible following some algos
    
    In this contract: 
    locked and ID are both public so they each get their own slots (0 and 1)
    flattening , denomination and akwardness are private, consecutive and occupy 4 bytes total (uint8 - 1 byte, uint16 - 2 bytes)
    they will be padded and written to the 2nd slot
    data is 32 bytes per element - each element will have its own slot
    data[0] - slot 3, data[1] - slot 4, data[2] - slot 5 ...
*/

//Commands to get the key from the web console:

//1. get the value at slot 5 at contract address
await web3.eth.getStorageAt(contract.address,5)
// => '0x08bdea200195df3f2988748731c26e377bc50fc1c48500cd58e2236076d30219'

//2. slice the value to get the first 16 of 32 bytes, as required in the unlock() fct
'0x08bdea200195df3f2988748731c26e377bc50fc1c48500cd58e2236076d30219'.slice(0,34)
// => 0x08bdea200195df3f2988748731c26e37
