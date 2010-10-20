@cms
Feature: Sign In
  In order to get access to protected sections of the site a user will be able to sign in

  Scenario: User does not have an account
    Given no user exists with an email of "email@badperson.com"
    When I sign in as "email@badperson.com/password"
    Then I should see "Bad email or password"
    And I should not be signed in

  Scenario: User enters wrong password
    Given I have an account "email@person.com/password"
    When I sign in as "email@person.com/wrongpassword"
    Then I should see "Bad email or password"
    And I should not be signed in

  Scenario: User signs in successfully
    Given I have an account "email@person.com/password"
    When I sign in as "email@person.com/password"
    Then I should be signed in
    When I return next time
    Then I should be signed in

  Scenario: User signs out
    Given I am signed in
    And I sign out
    Then I should see "Signed out"
    And I should be signed out
    When I return next time
    Then I should be signed out

