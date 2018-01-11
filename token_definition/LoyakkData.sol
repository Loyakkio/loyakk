pragma solidity ^0.4.18;


// Copyright 2018 Loyakk Ltd. All rights reserved.

contract LoyakkData {

  struct Message {
    address sender;
    address receiver;  
    string content;
    string url; 
  }

  enum GroupType {Escrow, Auditor, Vendor, Customer}

  struct Group {
    string name;
    GroupType gType;
  }


  struct User {
    string userId;
    address organization; 
    address group;
  }

  enum TransactionType {Subscription, Retail, Wholesale}
  enum PaymentType {OneTime, Hourly, Daily, Monthly, Annually}

  struct Transaction {
    address sender;
    address receiver; 
    string memo; 
    uint256 amount;
    PaymentType paymentType;
    TransactionType transactionType;
    uint256 date;
  }



  //Events 
  event MessageEvent(address from, address to, string content, string url);
  event TransactionEvent(address from, address to, string memo, uint256 amount, PaymentType paymentType, TransactionType transType);
  address owner; //The owner of the contract.

  
  // A calendar of working days for a year. This calendar 
  // drives computations such as business days, grace period for
  // a contract.
  mapping(uint256 => mapping(uint256 => bool)) holidays;

  string public name;

  string public description; 

  // This allows us to fractionalize the token. Default is 1
  uint8 public decimals; 

  ///@ The number of time units this contract is valid since creationDate
  /// or a hard date.
  uint public expirationDate;

  ///@ The date when the contract can start.
  uint public commencementDate; 

  ///@ Creation date is when the contract was created, 
  /// and provides a way to manage a contract without actually
  /// allowing the contract to take effect.
  uint public creationDate;




  // All the conversations started by a user.
  mapping (address => Message) public messageRecipients;

  mapping (uint => Transaction) transactions;
  mapping(uint => address[]) groupMembership;


  function validDateRange() internal constant returns(bool) {
    (creationDate <= commencementDate) && (commencementDate <= expirationDate);
  }
  function isHoliday(uint256 year, uint256 aDate) internal constant returns (bool) {
      (holidays[year])[aDate];
  }
  function isWorkindDay(uint256 year, uint256 aDate) internal constant returns(bool){
    !isHoliday(year, aDate);
  }
  // Minimal validation, all dates should be in future.
  function validDate(uint aDate) internal constant returns (bool) {
    aDate >= now;
  }

  function LoyakkData(string aName, string aDescription, 
        uint8 aDecimalHint, uint aCreationDate, uint aCommencementDate, uint anExpirationDate) public {
    owner = msg.sender;
    name = aName;
    description = aDescription;
    decimals = aDecimalHint;
    if(validDate(creationDate) && validDate(commencementDate) && validDate(expirationDate)) {
      if(validDateRange()) {
        creationDate = aCreationDate;
        commencementDate = aCommencementDate;
        expirationDate = anExpirationDate;        
      }else {
        revert();
      }
    }else {
      //Dont create a contract with invalid dates.
      revert();
    }

  }

  //Note: Creation date cannot be updated. We can manipulate
  //commencement and expiration date, but standard conditions apply
  function updateExpirationDate(uint256 aDate) pure internal{
    if(aDate >= commencementDate){
      expirationDate = aDate;
    } else {
      revert();
    }
  }

  function updateCommencementDate(uint256 aDate) {
    if(aDate >= creationDate) {
      commencementDate = aDate;
    } else {
      revert();
    }
  }

  function getGroupId(string groupName, GroupType groupType) pure internal {
    keccak256(groupName, groupType);
  }
  function broadcastMessage(string content, string url, uint groupId) public {
    address [] storage addresses = groupMembership[groupId];
    for(uint i = 0; i < addresses.length; i++) {
      sendMessage(content, url, addresses[i]);
    }
  }

  //Send a message to a recipient. 
  function sendMessage(string content, string url, address recipient) public {
    messageRecipients[recipient] = Message(owner, recipient, content, url);
    MessageEvent(owner, recipient, content, url);
  }
  //Add transaction to the contract. 
  function createTransaction(address _sender, 
          address _receiver, 
          string _aMemo,
          uint256 amount, 
          PaymentType paymentType, 
          TransactionType aTransactionType) public {
    uint id = uint(keccak256(Transaction(_sender, _receiver, _aMemo, amount, paymentType, aTransactionType, now)));
    transactions[id] = Transaction(_sender, _receiver, _aMemo, amount, paymentType, aTransactionType, now);
    TransactionEvent(_sender, _receiver, _aMemo, amount, paymentType, aTransactionType);
  }



  function kill() public {
    if(msg.sender == owner) {
      selfdestruct(owner);
      }
  }

}
