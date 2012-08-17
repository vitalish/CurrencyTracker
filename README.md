CurrencyTracker
===============

CurrencyTracker allows you to track your personal collection of world currencies, by tagging the countries that you've visited along your travels.

Features
--------

* Track Visited Countries
* Track Collected Currencies
* Charts show you how far along you are!

Install
-------
Update Bundler ( Gemfile was fixed to work with Bundler version 1.1.4.).
Install Firefox ( selenium-webdriver was updated to work with latest).
Do not forget run rake db:seed to create demo data
Demo login: test@example.com
Demo password: 123456

Assumptions
-----------

* Improve rather then rewrite.
* Existing Application Currency to Country relation doesn't allow one currency to be used in Multiple Countries. I assume it is enough for  the test assignment.
* I assume Collecting Currency means visiting Country that has this Currency. Such visit can collect additional currencies if Country has more then one Currency.
* Currencies and countries tables are shared between users. Visits are per user.
* User use email to sign up and sign in.
* Basic functionality is available for browser without javascript. Some enhancements such as line graph, filtering and 'Select All' functionality work only with javascript enabled.
* Undo functionality is implemented on the Currencies and Countries show pages.

Enhancements
------------

1. Multi-­tenant app
-------------------

* Added devise gem to support user authentication.
* Added Visit model to indicate user visiting countries.
* To select countries/currencies that visited/collected I used custom join which is not very crucial for such small project but allows to reduce array iterations in ruby.

2. Additional Table Features
----------------------------

* Added ability for user to Visit multiple countries.
* Added unobtrusive javascript to allow submitting visits without page reload.
* Reload chart on new visits. I didn't find a quick way to reuse SimplePieChart so I just altered the url for image with the help of regexp.
* Filtering Countries by name. As the number of countries and currencies are pretty small and not going to change often I decided to implement filtering on cline side.
* Select all - selects countries that are currently visible to the user and not visited yet.
* Added ability for user to Collect currencies.
* Added table enhancements for Currencies the same as for Countries.

3. Additional Charting Features
-------------------------------

* Added line graph for Visiting and Collecting progress. I used Highcharts because they are awesome and I had used them no long before.

Note
----
I usually use rspec for writing test and write tests in a little bit another manner then used in this project. I rarely use cucumber except the cases when I want to document api with help of it or it is requested by product owner. I think in most cases it takes more time then just using capybara with rspec. Although, using newer version of rails is more comfortable for development, I left everything as is, because migration and test rewriting are always time consuming and I think out of the scope of test assignment.
I didn't have time to fix database cleaner so if test fail with validation errors please do rake db:test:prepare or run cucumber through rake (rake cucumber).

Future Improvements
-------------------
If I had more time and/or was doing test assignment from scratch I would use backbone.js or sencha or some other JS framework that will simplify developing of rich application and ease porting to mobile devices.
