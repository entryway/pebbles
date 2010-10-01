Feature: Admin chooses primary product image
  In order to display the most appealing product image to the customer first
  As an admin
  I want to choose a primary product image

  Background:
    Given the following categories:
      | name |
      | Root |

  @javascript
  Scenario: Admin uploads two images and selects one of them to be primary
    Given I am logged in as an admin
    And the following products exist:
      | name |
      | Foo  |
    And I am on the "Foo" edit admin product page
    And I follow "Images"
    And I attach a regular product image "test.jpg"
    And I press "upload"
    And I wait 2 seconds
    And I am on the "Foo" edit admin product page
    And I follow "Images"
    And I attach a regular product image "test.jpg"
    And I press "upload"
    And I wait 2 seconds
    Then show me the page
