# LEWT Technical White Paper
http://www.getlewt.com

**July 10, 2017**

**Abstract:** The Lewt software introduces a technology that allows for any HTML element to be monetized. It connects the element type, id, class and its location on the page with a value and cooldown period that controls how often the element value (“loot”) can be earned by a website visitor. HTML elements can be chained together over multiple pages to require clicks to be performed in a sequence before loot is transferred. Loot can also be distributed in reverse as donations for viewing content or charges for premium content. The GetLewt platform is the first implementation of this technology.

Copyright © 2017 Virtual Tradewinds Inc.

DISCLAIMER: This LEWT Technical White Paper is for information purposes only. Virtual Tradewinds Inc. does not guarantee the accuracy of or the conclusions reached in this white paper, and this white paper is provided “as is”. Virtual Tradewinds Inc. does not make and expressly disclaims all representations and warranties, express, implied, statutory or otherwise, whatsoever, including, but not limited to: (i) warranties of merchantability, fitness for a particular purpose, suitability, usage, title or noninfringement; (ii) that the contents of this white paper are free from error; and (iii) that such contents will not infringe third-party rights. Virtual Tradewinds Inc. and its affiliates shall have no liability for damages of any kind arising out of the use, reference to, or reliance on this white paper or any of the content contained herein, even if advised of the possibility of such damages. In no event will Virtual Tradewinds Inc. or its affiliates be liable to any person or entity for any damages, losses, liabilities, costs or expenses of any kind, whether direct or indirect, consequential, compensatory, incidental, actual, exemplary, punitive or special for the use of, reference to, or reliance on this white paper or any of the content contained herein, including, without limitation, any loss of business, revenues, profits, data, use, goodwill or other intangible losses.

## Background
Content creators are finding it increasingly difficult to make a living from ad revenue and other online streams of income. Revenue is often outside of the content creator’s control and in the hands of third party services through companies like Google. 
 
Many artists and designers rely on multiple websites to reach a larger audience, but without having the ability to control how to monetize the content. In most cases they have to pay a percentage to the platform they are using as well. Alternative monetization options are inadequate and usually directs the user away from the content in order to transact a general donation or setup a subscription. Popular online platforms may also limit their users by censoring content that does not comply with their rules, and automatically obtain full rights to all files uploaded. 
 
Lewt offers a stand-alone monetization layer that can be added to any website or online service. The technology empowers content creators to monetize their content no matter where it is located. It works across domains and between web pages through a combination of techniques that avoids common limitations in browsers. Lewt charges no fee for transactions, deposits or withdrawals and is completely free to use.

## Token
The Lewt token (coin) removes the dependency on third parties for receiving and sending payments and donations. It is the currency of a growing decentralized marketplace of creative services offered by Lewt users through their own websites or via the GetLewt platform. The GetLewt platform is the first implementation of Lewt and is designed to make it easy for users to get paid through micro donations for their work using the Lewt token. The platform uses its themes to hide most of the functionality of Lewt from the user and automatically monetizes the uploaded or linked content. 

## Transactions
The Lewt technology supports microtransactions down to a fraction of a coin and adds no fees to transactions made between users of the GetLewt platform or any other future implementation of Lewt. Due to the rising cost of transacting on the Ethereum blockchain and our need to process microtransactions instantly, transactions are bundled and released to the blockchain during withdrawals and deposits. 
 
Lewt will take full advantage of the Raiden network once it becomes stable, as it will solve the current issues with the Ethereum blockchain that relate directly to Lewt. Every aspect of Lewt will go through the blockchain as transaction speed and cost improves.

## Front-end techniques
### Monetizing HTML elements
The Lewt script looks at the domain it is called from and sends this information via the Lewt API to retrieve all monetized CSS class and id names defined by the domain user. The API returns information about how much they are worth and their cooldown period for the current user. A click could represent a donation or a charge, depending on the setup. Any element can be monetized, including DIV, SPAN, IMG and other non-redirecting elements.
 
Example:
```
<a id=”#myid” class=”myclass” href=”mydomain.com”>Click me</a> 
```
This hyperlink can be monetized by using the HTML element type A, using the class name called “myclass” or using the id name “myid”. If the class name is used, it will be entered in Lewt as “.myclass”. If the id name is used as identifier, it will be entered as “#myid”. There may be multiple elements with this class name or of this type on a page, so each element is assigned a unique id matching the identifier which is added as an attribute. 
 
Element after monetization:
```
<a id=”#myid” class=”myclass” href=”mydomain.com” loot=”h1ui87” value=”0.1”>Click me</a> 
```
When the web page is loading, the Lewt script scans the page and inserts the loot attribute with a unique code and a loot value into each monetized element. A click on one of these elements displays the amount in the value attribute as an animation at the pointer location and sends the unique code via the Lewt API to be verified. The verification process happens before the link redirects the browser and takes less than 200ms. 

## window.name transport
Normally, a website has to specifically approve of protected content coming from another domain via an iframe to allow cross-domain data transfer. Lewt is utilizing a technique called window.name transport to ensure secure cross-domain browser based data transfers and to allow the full content of the Lewt gallery to load in the iframe. It takes advantage of the 2MB space allocated to the name of the browser tab which is not being utilized, and stores data in this space. This data can be passed to different parts of the browser independent of the domains it is displaying. GetLewt offers a monetized gallery iframe widget that can be added to any website using this approach.

## Click sequences
Lewt supports click sequences that award loot only after multiple HTML elements have been clicked in the right order. Each click made on monetized elements is tracked in a chain of unique loot id’s and stored in the window.name space, enabling tracking of click sequences between web pages and even domains without using cookies. 
 
When a click sequence defined by the domain user is matched with a sequence stored in the window.name space, the specified loot amount is transferred to the user that successfully completed the click sequence. This can be used to encourage website visitors to explore content or perform certain actions in order to get a reward.
 
Click sequences can also be used for analytical purposes when setup with zero loot values for  generic HTML elements such as hyperlinks and images. Having information about the user’s navigation through the website can give insights valuable for marketing purposes.

## Cooldown periods
A monetized element can be assigned a cooldown period to prevent triggering multiple microtransactions from the same element in a short time period. This allows the domain owner to set up a webpage where visitors can earn a certain amounts of Lewt coins in a day, and need to come back the next day to earn more.
 
During page load, all monetized elements are checked for active cooldown periods before being assigned a loot value and unique loot id. If an element has cooldown activated and was recently looted by the user, it will not be assigned a loot attribute and will be ignored by Lewt until the cooldown has reset and the page is reloaded.

## Conclusion
Lewt is a technology that enables anyone to monetize their online content independent of any platform or ad agency. The GetLewt platform has reached the first milestone by proving the technology and will continue to implement our long term vision of supporting content creators around the world.
