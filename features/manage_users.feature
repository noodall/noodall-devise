Feature: Manage users
  In order to control who can access the Client Area and CMS a website administrator will be able to manage user accounts

  Background:
    Given I am signed in as a website_administrator

  Scenario: List Users
    Given 20 users exist
    And I am on the users admin page
    Then I should see a list of users

  Scenario: Create a User
    Given I am on the users admin page
    And I follow "Create New User"
    When I fill in the following:
      | Name                  | Mr Spoon              |
      | Email                 | spoon@buttonmoon.com  |
      | Password              | s3cur3                |
      | Password confirmation | s3cur3                |
    And press "Create"
    Then the user should be able to sign in as "spoon@buttonmoon.com/s3cur3"

  Scenario: Edit User information
    Given 20 users exist
    And I am on the users admin page
    Then I should be able to edit a user's information

  Scenario: Delete a User
    Given 20 users exist
    And I am on the users admin page
    Then I should be able to delete a user
    Then that user should not be able to sign in
