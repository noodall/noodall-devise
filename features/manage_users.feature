Feature: Manage users
  In order to control who can access the Client Area and CMS a website administrator will be able to manage user accounts

  Background:
    Given I am signed in as a website_administrator

  Scenario: List Users
    Given 20 users exist
    And I am in the cms
    When I follow "Users" within "ul#topnav"
    Then I should see a list of users

  Scenario: Create a User
    Given I am on the users admin page
    When I follow "Create New User"
    And I fill in the following:
      | Name                  | Mr Spoon              |
      | Email                 | spoon@buttonmoon.com  |
      | Password              | s3cur3                |
      | Password confirmation | s3cur3                |
    And press "Create"
    Then the user should be able to sign in as "spoon@buttonmoon.com/s3cur3"

  Scenario: Edit User information
    Given a user exists with the attrubutes:
      | name                  | Mr Spoon              |
      | email                 | spoon@buttonmoon.com  |
      | password              | s3cur3                |
      | password_confirmation | s3cur3                |
    And I am on the users admin page
    When I follow "Mr Spoon"
    And I fill in "Email" with "spoon@hotmail.com"
    And press "Update"
    Then the user should be able to sign in as "spoon@hotmail.com/s3cur3"


  Scenario: Delete a User
    Given a user exists with the attrubutes:
      | name                  | Mr Spoon              |
      | email                 | spoon@buttonmoon.com  |
      | password              | s3cur3                |
      | password_confirmation | s3cur3                |
    And I am on the users admin page
    When I follow "Delete" within "tr:contains('Mr Spoon')"
    Then the user should not be able to sign in as "spoon@buttonmoon.com/s3cur3"

  Scenario: Groups List for autocomplete
    Given the following users exists:
       | name     | group list      |
       | Mr Spoon | admin, editor   |
       | Dave     | editor          |
       | Eric     | editor, manager |
    When I go to the groups json
    Then I should see JSON:
      """
      ["admin","editor","manager"]
      """
