//A messaging shell for Loyakk messages.
pragma solidity ^0.4.18;


// Copyright 2018 Loyakk Ltd. All rights reserved.

contract LoyakkMessage {
  //An attachment type can be an image, an invoice or a purchase order.
  //More types to be added as needed. Client applications should be able to decode the url based on the 
  //attachhment type. 
  //For example, loyakk://image/<image_hash>
  // loyakk://invoice/<invoice_hash>
  // loyakk://purchaseorder/<po_hash>
  enum AttachmentType {Image, Invoice, PurchaseOrder}
  
  struct Attachment {
    AttachmentType attachmentType;
    uint256 attachmentHash; //A hash to the url to access the file.
  }
  address owner;
  address sender;
  address receiver;
  string content;
  string url;
  uint256 attachmentHash;

  function LoyakkMessage(address aSender, address aReceiver, string message, uint256 anAttachmentHash) {
    owner = msg.sender;
    sender = aSender;
    receiver = aReceiver;
    content = message;
    attachmentHash = anAttachmentHash;
  }
}

