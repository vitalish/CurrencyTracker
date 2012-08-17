Feature: Manage currencies
  In order to manage his currencies collection
  Mr. Smart
  wants to manage the currencies he has collected.

  Scenario: List Currencies
    Given the following countries exist:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
    And the following currencies exist:
      |name|code|country_id|
      |CurrencyOne|cu1|c1|
      |CurrencyTwo|cu2|c2|
    And the following users exist:
      |email|password|
      |user1@example.com|123456|
      |user2@example.com|123456|
    And the following visits exist:
      |email|code|
      |user1@example.com|c2|
      |user2@example.com|c1|
    And I am logged in user with email "user1@example.com" and password "123456"
    When I am on the currencies page
    Then I should see the following table:
      |Name|Code|Status|
      |CurrencyOne|cu1|Not Collected|
      |CurrencyTwo|cu2|Collected|

  Scenario: Collect/Uncollect Currency
    Given the following countries exist:
      |name|code|
      |CountryOne|c1|
    And the following currencies exist:
      |name|code|country_id|
      |CurrencyOne|cu1|c1|
    And I am logged in user
    And I am on the currencies page
    And I follow "Show"
    And I should see "Status: Not Collected"
    When I press "Collect"
    Then I should see "Status: Collected"
    Then I press "Delete Collection"
    And I should see "Status: Not Collected"

  @javascript
  Scenario: Filter currencies
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
    And the following currencies exist:
      |name|code|country_id|
      |Chad Currency|cu1|c1|
      |China Currency|cu2|c2|
      |CountryThree Currency|cu3|c3|
      |Czech Republic Currency|cu4|c4|
      |CountryFive Currency|cu5|c5|

    And I am logged in user with email "user1@example.com" and password "123456"
    And I am on the currencies page
    When I fill in "filter" with "ch"
    And I press "Select All"
    And I press "Collect Selected"
    And I am on the currencies page
    Then I should see the following table:
      |Name|Code|Status|
      |Chad Currency|cu1|Collected|
      |China Currency|cu2|Collected|
      |CountryThree Currency|cu3|Not Collected|
      |Czech Republic Currency|cu4|Collected|
      |CountryFive Currency|cu5|Not Collected|

