pragma solidity ^0.4.18;

import "./counter.sol";

contract CounterFactory {
  mapping(address => address) counters;

  modifier doesNotExist() {
    require(counters[msg.sender] == 0);
    _;
  }

  modifier exists() {
    require(counters[msg.sender] != 0);
    _;
  }

  function createCounter() public doesNotExist {
    counters[msg.sender] = new Counter(msg.sender);
  }

  function increment() public exists {
    Counter(counters[msg.sender]).increment(msg.sender);
  }

  function getCount(address _account) public view returns (uint) {
    require(_account != 0);
    return Counter(counters[msg.sender]).getCount();
  }
}
