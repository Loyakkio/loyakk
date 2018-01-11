pragma solidity ^0.4.18;

//Copyright Loyakk Ltd. 2018
/// A contract to allow parties to review a LoyakkContract, similar to what 
/// most review sites offer.
contract LoyakkReview {
	enum Rating {Excellent, Good, Fair}
	string public comments;
	Rating public rating;
	address public transaction; 
}
