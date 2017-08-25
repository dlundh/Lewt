pragma solidity ^0.4.10;

contract admined {
	address public admin;

	function admined(){
		admin = msg.sender;
	}

	modifier onlyAdmin(){
		if(msg.sender != admin) throw;
		_;
	}

	function transferAdmin(address newAdmin) onlyAdmin {
		admin = newAdmin;
	}
}

contract LewtCoins is admined {
    string public name;
    string public symbol;
    uint public tokenCap;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function LewtCoins(){
		balanceOf[msg.sender] = 0;		
        totalSupply = 0;
        tokenCap = 10000000000; // 100 million tokens with 2 decimals
		symbol = "LEC";
		name = "LewtCoins";
        decimals = 2;
	}

    function transfer(address _to, uint256 _value) {
        if (_to == 0x0) throw;
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
    }

    function mintToken(address target, uint256 mintedAmount) onlyAdmin {
		if (tokenCap >= (totalSupply + mintedAmount)) {
            balanceOf[target] += mintedAmount;
            totalSupply += mintedAmount;
            Transfer(0, this, mintedAmount);
            Transfer(this, target, mintedAmount);
        } else {
            throw;
        }
	}
}
