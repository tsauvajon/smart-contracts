pragma solidity ^0.4.18;

contract Lottery {
  mapping(address => uint) usersBet;
  mapping(uint => address) users;

  uint nbUsers = 0;
  uint totalBets = 0;

  address owner;

  modifier isOwner() {
    require(msg.sender == owner);
    _;
  }

  modifier hasValue() {
    require(msg.value > 0);
    _;
  }

  modifier onlyIf(bool _condition) {
    require(_condition);
    _;
  }

  function Lottery() public {
    owner = msg.sender;
  }

  function bet() public payable hasValue {    
    if (usersBet[msg.sender] == 0) { // new player
      users[nbUsers] = msg.sender;
      nbUsers++;
    }

    usersBet[msg.sender] += msg.value;
    totalBets += msg.value;
  }

  function endLottery() public isOwner {
    uint sum = 0;
    uint winningNumber = uint(block.blockhash(block.number - 1)) % totalBets;

    for (uint i = 0; i < nbUsers; i++) {
      sum += usersBet[users[i]];

      if (sum >= winningNumber) {
        // destroy this contract and send the balance to users[i]
        selfdestruct(users[i]);
        return;
      }
    }
  }
}
