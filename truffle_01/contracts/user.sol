pragma solidity ^0.4.24;

contract HelloToken{
	function hello() public pure{

	}

	function hello2() public view returns(string) {
		return "hello";
	}
}
contract owned {
        address public owner;

        function owned() {
                owner = msg.sender;
        }

        modifier onlyOwner {
                if (msg.sender != owner) throw;
                _
        }

        function transferOwnership(address newOwner) onlyOwner {
                owner = newOwner;
        }
}
contract token {
        function mintToken(address target, uint256 mintedAmount);
}
contract MyToken is owned {
        string public name;
        string public symbol;
        uint8 public decimals;
        uint256 public totalSupply;

        mapping(address => uint256) public balanceOf;
        mapping(address => bool) public frozenAccount;
        mapping(address => mapping(address => uint)) public allowance;
        mapping(address => mapping(address => uint)) public spentAllowance;


        event Transfer(address indexed from, address indexed to, uint256 value);
        event FrozenFunds(address target, bool frozen);

        function MyToken(uint256 initialSupply, string tokenName, uint8 decimalUnits, string tokenSymbol, address centralMinter) {
                if (centralMinter != 0) owner = centralMinter; // Sets the minter
                balanceOf[msg.sender] = initialSupply; // Give the creator all initial tokens
                name = tokenName; // Set the name for display purposes
                symbol = tokenSymbol; // Set the symbol for display purposes
                decimals = decimalUnits; // Amount of decimals for display purposes
                totalSupply = initialSupply;
       }
	   function transfer(address _to, uint256 _value) {
                if (balanceOf[msg.sender] < _value) throw; // Check if the sender has enough
                if (balanceOf[_to] + _value < balanceOf[_to]) throw; // Check for overflows
                if (frozenAccount[msg.sender]) throw; // Check if frozen
                balanceOf[msg.sender] -= _value; // Subtract from the sender
                balanceOf[_to] += _value; // Add the same to the recipient
                Transfer(msg.sender, _to, _value); // Notify anyone listening that this transfer took place
        }

        function mintToken(address target, uint256 mintedAmount) onlyOwner {
                balanceOf[target] += mintedAmount;
                totalSupply += mintedAmount;
                Transfer(owner, target, mintedAmount);
        }

        function freezeAccount(address target, bool freeze) onlyOwner {
                frozenAccount[target] = freeze;
                FrozenFunds(target, freeze);
        }

        function transferFrom(address _from, address _to, uint256 _value) returns(bool success) {
                if (balanceOf[_from] < _value) throw; // Check if the sender has enough
                if (balanceOf[_to] + _value < balanceOf[_to]) throw; // Check for overflows
                if (frozenAccount[_from]) throw; // Check if frozen
                if (spentAllowance[_from][msg.sender] + _value > allowance[_from][msg.sender]) throw; // Check allowance
                balanceOf[_from] -= _value; // Subtract from the sender
                balanceOf[_to] += _value; // Add the same to the recipient
                spentAllowance[_from][msg.sender] += _value;
                Transfer(msg.sender, _to, _value);
        }

        function approve(address _spender, uint256 _value) returns(bool success) {
                allowance[msg.sender][_spender] = _value;
        }

        function() {
                //owner.send(msg.value);
                throw;
        }
}
