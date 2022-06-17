pragma solidity >=0.7.0 <0.9.0;

// The contract only its creator to create new coins(different issuance schemes are possible)
// Anyone can send coins to each other without a need for registering with a username and password, all you need is an Ethereum keypair.

contract Coin {
    // the keyword public it's making the variables here accessible from other contracts
    address public minter;
    mapping(address => uint) public balance;

/* Event is an inheritable member of a contract. An event is emitted, it stores the arguments passed in tx logs,
These logs are stored on blockchain and are accessible using address of the contract till the contract is present on the blockchain.*/

    event Sent(address from, address to, uint amount);

    //constructor only runs when we deploy contract
    constructor(){
        minter = msg.sender;
    }
    
    // make new coins and send them to an address
    // only the owner can send theses coins
    function mint(address receiver, uint amount) public{
        require(msg.sender == minter);
        balance[receiver] += amount;
    }

    //send any amount of coins to an existing address
    // only the owner can send these coins
    
    error insufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        // require amount to be greater than x=true and then run this 
        if(amount > balance[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balance[msg.sender]
        });
        
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Sent(msg.sender,receiver,amount);
    }

}