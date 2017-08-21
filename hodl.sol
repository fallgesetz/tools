

contract ERC20 {
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    uint256 public totalSupply; //apparently public 


    function transfer(address _to, uint256 _value) returns (bool success) {
       //Default assumes totalSupply can't be over max (2^256 - 1).
       //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
       //Replace the if with this one instead.
       //require(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]);
       require(balances[msg.sender] >= _value);
       balances[msg.sender] -= _value;
       balances[_to] += _value;
       Transfer(msg.sender, _to, _value);
       return true;
   }
   function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
    //same as above. Replace this line with the following if you want to protect against wrapping uints.
    //require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]);
    require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value);
    balances[_to] += _value;
    balances[_from] -= _value;
    allowed[_from][msg.sender] -= _value;
    Transfer(_from, _to, _value);
    return true;
}
   function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}

contract HODLToken is ERC20{
    // ERC20 compliant token that takes your money and does (does it?) really give it back.
    string public constant symbol = "HODL";   
    string public constant name = "TAKE MY MONEY PLEASE";
    uint8 public constant decimals = 18;
    
    mapping(address => uint) holdingTime;
    mapping(address => uint) holdingEthers;
    
    uint public beginTime;
    uint public beginBlock; 
    address owner;
    
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function HODLToken() {
        beginTime = block.timestamp;
        beginBlock = block.number;
        owner = msg.sender;
    }
    
    function payIn(uint howMuchTime) payable {
        holdingEthers[msg.sender] = msg.value;
        holdingTime[msg.sender] = howMuchTime;
    }
    
    function withdraw() returns (bool canYou) {
        if(holdingTime[msg.sender] + beginTime < block.timestamp) {
            msg.sender.transfer(holdingEthers[msg.sender]);
            holdingEthers[msg.sender] = 0;
            holdingTime[msg.sender] = 0;
            return true;
        }
        return false;
    }
    
    function ownerWithdraw(uint amount) isOwner {
        require(amount < this.balance);
        msg.sender.transfer(amount);
    }

    
    function transferOwnership(address newOwner) isOwner {
        owner = newOwner;
    }
    
}


