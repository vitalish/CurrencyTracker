Feature: Register new user
  In order to use application
  User
  wants to register.

  Scenario: Create new user
    Given I am on the home page
    When I follow "Sign up"
    When I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "123456"
    And I fill in "Password confirmation" with "123456"
    And I press "Sign up"
    Then I should see "Currencies"

  Scenario: Login as user
    Given I am registered user with email "someuser@example.com" and password "123456"
    And I am on the home page
    When I fill in "Email" with "someuser@example.com"
    And I fill in "Password" with "123456"
    And I press "Sign in"
    Then I should see "Currencies"