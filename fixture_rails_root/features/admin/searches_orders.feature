Feature:
  In order to efficiently find orders
  As an admin
  On the admin orders page
  I want to search orders by full name or order number

  Background:
    Given I am logged in as an admin
    And the following orders:
      | full_name | order_number |
      | Foo Bar   | 12345        |
      | Jon Doe   | 76832        |
      | Bob Will  | W-1234       |
    And I am on the admin orders page

  Scenario Outline:
    When I fill in "<search>" for "search"
    And I press "search"
    Then I should see "<full_name>" within ".full_name"
    And I should see "<order_number>" within ".order_number"
    And I should not see "<unmatched full_name>" within ".full_name"
    And I should not see "<unmatched order_number>" within ".order_number"

    Examples:
      | search | full_name | order_number | unmatched full_name | unmatched order_number |
      | foo    | Foo Bar   | 12345        | Jon Doe             | 76832  |
      | 12345  | Foo Bar   | 12345        | Jon Doe             | 76832  |

  Scenario: Admin searches order by case insensitive order number
    When I fill in "w-1234" for "search"
    And I press "search"
    Then I should see "W-1234" within ".order_number"
