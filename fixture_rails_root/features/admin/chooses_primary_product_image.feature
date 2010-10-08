Feature: Admin chooses primary product image
  In order to display the most appealing product image to the customer first
  As an admin
  I want to choose a primary product image

  Background:
    Given I am logged in as an admin
    Given the following categories:
      | name |
      | Root |
    And the following products exist:
      | name |
      | Foo  |
    And I am on the "Foo" edit admin product page
    And I follow "Images"

  @javascript
  Scenario: Admin uploads one image and marks it primary
    When I attach a regular product image "test.jpg"
    And I press "upload"
    And I wait 2 seconds
    When I press "set_primary_product_image_1"
    Then I should see "This image is primary." within "div#primary_product_image_1"

  @javascript
  Scenario: Admin uploads two images and marks both to be primary
    When I attach a regular product image "test.jpg"
    And I press "upload"
    And I wait 2 seconds
    And I attach a regular product image "test.jpg"
    And I press "upload"
    And I wait 2 seconds
    Then I should see "1st Image"
    And I should see "2nd Image"
    When I press "set_primary_product_image_1"
    Then I should see "This image is primary." within "div#primary_product_image_1"
    And I press "set_primary_product_image_2"
    Then I should see "This image is primary." within "div#primary_product_image_2"
    And I should not see "This image is primary." within "div#primary_product_image_1"
