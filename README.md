CurrencyTracker
===============

CurrencyTracker allows you to track your personal collection of world currencies, by tagging the countries that you've visited along your travels.

Features
--------

* Track Visited Countries
* Track Collected Currencies
* Charts show you how far along you are!


Environment
-----------
I developed under 1.8.7-p358 using rbenv and Bundler version 1.1.4.


Enhancements
------------
This is what I managed to accomplish within 6 hours:
1. Multi-­tenant app
* Added devise gem to support user authentication.
* Added Visit model to indicate user visiting countries.
* To select countries/currencies that visited/collected I used custom join which is not very crucial for such small project but allows to reduce array iterations in ruby.
2. Additional Table Features
* Added ability for user to Visit multiple countries.
* Added unobtrusive javascript to allow submitting visits without page reload.
* Reload chart on new visits. I didn't find a quick way to reuse SimplePieChart so I just altered the url for image with the help of regexp.
* Filtering Countries by name. As the number of countries and currencies are pretty small and not going to change often I decided to implement filtering on cline side.
* Select all - selects countries that are currently visible to the user and not visited yet.

Note
----
I usually use rspec for writing test and write tests in a little bit another manner then used in this project. I rarely use cucumber except the cases when I want to document api with help of it or it is requested by product owner. I think in most cases it takes more time then just using capybara with rspec. Although, using newer version of rails is more comfortable for development, I left everything as is, because migration and test rewriting are always time consuming and I think out of the scope of test assignment.
I didn't have time to fix database cleaner so if test fail with validation errors please do rake db:test:prepare.

Future Improvements
-------------------
If I had more time and/or was doing test assignment from scratch I would use backbone.js or sencha or some other JS framework that will simplify developing of rich application and ease porting to mobile devices.
