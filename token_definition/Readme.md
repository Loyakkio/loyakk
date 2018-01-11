

h2. Contents

h3. Loyakk.sol
Defines the Loyakk token at a high level. Loyakk token is a prerequisite to using the Vega Platform.

h3. LoyakkData.sol
Data token captures the rest of the data flow for the processes that need to be 
onboarded into the Vega platform. For example, a token to describe a supply contract
between a vendor is reflected here. This contract in effect reflects most of the 
business processes that need to managed by the blockchain.

h3. LoyakkMessage.sol
Messages are units of communication between a sender and one or more receivers. The messages can encapsulate images, purchaseorders, invoices for entities in a transaction.


h3. LoyakkProduct.sol
Product hierarchy describing the types of products that can be managed. 


h3. LoyakkReview.sol
Where there is a product, a review cannot be far behind. Since these are part of the block chain, 
each review is a transaction that clients can listen to, in order to follow a products market feedback.



h4. Copyright
Copyright, Loyakk Ltd. 2018. All rights reserved.