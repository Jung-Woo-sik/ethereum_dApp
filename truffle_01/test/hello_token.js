const HelloToken = artifacts.require("./HelloToken.sol");

contract('HelloToken',(accounts) =>{
	it("hello2",() => {
	return HelloToken.deployed().then(instance => {
	instance.hello2().then(result => console.log(result))
	});
	});
});
