pragma solidity ^0.4.0;


contract Foo {
    uint c;
    address[] users;
    
    function add(uint a, uint b) constant returns(uint d) {
        c = a + b;
        return c;
    }
    function send_something() {
        address metamask= 0xFb67542fe746929D171008C78Bf131A6D94C1a7D;
        if(this.balance > 10) 
            metamask.transfer(10);
    }
    function get_balance() constant returns (uint balance){
        return this.balance;
    }
    
    function() payable {
        users.push(msg.sender);
    }
    
    function kill() {
        address owner = 0x001aeBE9217fbe184Fd89E947f4449041ECc6437;
        suicide(owner);
    }
    
    
}
