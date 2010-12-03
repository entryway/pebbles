Feature: Admin creates product

  Scenario: Admin tries creating product without weight and product is invalid
    Given I configure shipping_calculation_method: "weight"
    And I am logged in as an admin
    And I am on the new admin product page
    And I fill in "product_weight" with ""
    And I press "add-product"
    Then I should see "Weight can't be blank"
