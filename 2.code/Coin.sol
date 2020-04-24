pragma solidity ^0.5.17;

contract Coin {
    address public minter;
    //mapping is a reference type. Here address is mapped to balances[] array
    mapping (address => uint) public balances;

    constructor() public{
        //msg contains data like sender's address, wei sent etc.
        minter = msg.sender; //address of contract creator is stored as minter address.
    }

    function mint(address receiver, uint amount) public {
        if(msg.sender != minter) return;
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver,  amount);
    }

    //generate event. They can be listened to. It is similar to logging.
    event Sent(address from, address to, uint amount);
}