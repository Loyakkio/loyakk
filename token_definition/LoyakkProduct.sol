pragma solidity ^0.4.18;

// Copyright Loyakk Ltd. 2018

// A sample product hierarchy to manage products. 
// Products can be physical products with
// delivery and pickup requirements or 
// could be digital assets with a scheduled
// delivery requirements.
contract LoyakkAsset {

}

contract LoyakkPhysicalProduct is LoyakkAsset {
	enum Unit {FPS, Metric}
	enum PhysicalProperty {Solid, Liquid, Gas}
	string public name;
	string public urlToMsds;
	uint256 public pricePerUnit;
	Unit public unitOfMeasure;
	PhysicalProperty public physicalProperty;
	uint public shelfLife;
	string public manufacturersBatchId;
}

contract LoyakkDigitalAsset is LoyakkAsset {
	string public name;
	string public urlToAccess;
	//Many many more attributes.
}

contract LoyakkAudioAsset is LoyakkAsset {

}

contract LoyakkVideoAsset is LoyakkAsset {

}




