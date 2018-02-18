pragma solidity ^0.4.18;

contract Counter {
  uint count = 0;
  address owner;
  address factory;
  
  modifier isOwner(address _caller) {
    require(_caller == owner);
    require(msg.sender == factory);
    _;
  }

  function Counter(address _owner) public {
    owner = _owner;
    factory = msg.sender;
  }

  function increment(address _caller) public isOwner(_caller) {
    count++;
  }

  function getCount() public view returns (uint) {
    return count;
  }

  function kill() public {
    require(msg.sender == owner);
    selfdestruct(owner);
  }
}
