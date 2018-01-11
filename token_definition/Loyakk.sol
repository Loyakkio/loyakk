pragma solidity ^0.4.18;


//Copyright 2018 Loyakk Ltd.

contract Loyakk {

  string public name;
  string public symbol;
  uint8 public decimals;
  address private owner;

  mapping (address => uint256) public balanceOf;

  event Transfer(address indexed from, address indexed to, uint256 value);
  
  function VegaToken(uint256 _supply, string _name, string _symbol, uint8 _decimals) public {
      if (_supply == 0) {
          _supply = 1000000;
      }
      owner = msg.sender;
      balanceOf[msg.sender] = _supply;
      name = _name; 
      symbol = _symbol;
      decimals = _decimals;
  }

  function transfer(address _to, uint256 _value) public {
      if (balanceOf[msg.sender] < _value) {
        revert();
      }
      if (balanceOf[_to] + _value < balanceOf[_to]) {
        revert();
      }

      balanceOf[msg.sender] -= _value;
      balanceOf[_to] += _value;

      Transfer(msg.sender, _to, _value);
  }

  function kill() public {
    if(msg.sender == owner){
      selfdestruct(owner);
    }
  }

}
