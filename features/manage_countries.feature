Feature: Manage countries
  In order to manage his travel itinerary
  Mr. Smart
  wants to manage the countries he has visited.

  Scenario: List Countries
    Given the following countries exist:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
    And the following users exist:
      |email|password|
      |user1@example.com|123456|
      |user2@example.com|123456|
    And the following visits exist:
      |email|code|
      |user2@example.com|c1|
      |user2@example.com|c3|
      |user1@example.com|c3|
      |user1@example.com|c4|
    And I am logged in user with email "user1@example.com" and password "123456"
    When I am on the countries page
    Then I should see the following table:
      |Name|Code|Status|
      |CountryOne|c1|Not Visited|
      |CountryTwo|c2|Not Visited|
      |CountryThree|c3|Visited|
      |CountryFour|c4|Visited|
      |CountryFive|c5|Not Visited|

  Scenario: Visit/Unvisit Country
    Given I am logged in user
    And I am on a country page
    And I should see "Status: Not Visited"
    When I press "Visit"
    Then I should see "Status: Visited"
    Then I press "Delete Visit"
    And I should see "Status: Not Visited"

  Scenario: Visiting Country adds Collection
    Given the following countries exist:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
    And the following currencies exist:
      |name|code|country_id|
      |CurrencyOne|cu1|c1|
      |CurrencTwo|cu2|c2|
    And the following users exist:
      |email|password|
      |user1@example.com|123456|
    And I am logged in user with email "user1@example.com" and password "123456"
    When I am on the countries page
    And I follow "Show"
    And I press "Visit"
    And I follow "CurrencyOne"
    Then I should see "Status: Collected"

  Scenario: Visit slected countries
    Given the following countries exist:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
    And the following users exist:
      |email|password|
      |user1@example.com|123456|
    And I am logged in user with email "user1@example.com" and password "123456"
    And I am on the countries page
    And I should see the following table:
      |Name|Code|Status|
      |CountryOne|c1|Not Visited|
      |CountryTwo|c2|Not Visited|
      |CountryThree|c3|Not Visited|
      |CountryFour|c4|Not Visited|
      |CountryFive|c5|Not Visited|
    When I select country with code "c1"
    When I select country with code "c4"
    And I press "Visit Selected"
    Then I should see the following table:
      |Name|Code|Status|
      |CountryOne|c1|Visited|
      |CountryTwo|c2|Not Visited|
      |CountryThree|c3|Not Visited|
      |CountryFour|c4|Visited|
      |CountryFive|c5|Not Visited|

  @javascript
  Scenario: Filter countries
    Given the following countries exist:
      |name|code|
      |Chad|c1|
      |China|c2|
      |CountryThree|c3|
      |Czech Republic|c4|
      |CountryFive|c5|
    And the following users exist:
      |email|password|
      |user1@example.com|123456|
    And I am logged in user with email "user1@example.com" and password "123456"
    And I am on the countries page
    When I fill in "filter" with "ch"
    And I press "Select All"
    And I press "Visit Selected"
    And I am on the countries page
    Then I should see the following table:
      |Name|Code|Status|
      |Chad|c1|Visited|
      |China|c2|Visited|
      |CountryThree|c3|Not Visited|
      |Czech Republic|c4|Visited|
      |CountryFive|c5|Not Visited|

