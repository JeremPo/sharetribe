@sphinx @no-transaction
Feature: Search
  In order to find needed contents
  As a user
  I want to search listings by typing a keyword to search box and hitting enter
  
  
  Background:
    Given there is a numeric field "Weight (kg)" in community "test" for category "Items" with min value "0" and max value "200"
    
    And there is a listing with title "old sofa for sale" with category "Items" and with transaction type "Selling"
    And that listing has a description "I'm selling my wonderlful pink sofa!"
    And that listing has a numeric answer "100" for "Weight (kg)"
    
    And there is a listing with title "light-weigth plastic outdoor sofa" with category "Items" and with transaction type "Selling"
    And that listing has a description "Very light weight sofa for outdoor use"
    And that listing has a numeric answer "20" for "Weight (kg)"

    And the Listing indexes are processed
    And the CustomFieldValue indexes are processed

    And I am on the home page

  @javascript
  Scenario: basic search
    When I fill in "q" with "sofa"
    And I press "search-button"
    Then I should see "old sofa for sale"
    
  @javascript
  Scenario: should exclude non-matching results
    When I fill in "q" with "chair"
    And I press "search-button"
    Then I should not see "old sofa for sale"
    And I should see "We couldn't find any results that matched your search criteria"

  @javascript
  Scenario: Finding by description
    When I fill in "q" with "pink"
    And I press "search-button"
    Then I should see "old sofa for sale"

  @javascript
  Scenario: Finding by partial word
    When I fill in "q" with "wond"
    And I press "search-button"
    Then I should see "old sofa for sale"

    When I fill in "q" with "ofa"
    And I press "search-button"
    Then I should see "old sofa for sale"

  @javascript
  Scenario: Finding by numeric field (and search term)
    When I set search range for "Weight (kg)" between "10" and "200"
    And I press "Update view"
    Then I should see "old sofa for sale"
    Then I should see "light-weigth plastic outdoor sofa"

    When I set search range for "Weight (kg)" between "100" and "200"
    And I press "Update view"
    Then I should see "old sofa for sale"
    Then I should not see "light-weigth plastic outdoor sofa"

    When I fill in "q" with "light-weight"
    And I press "search-button"
    Then I should see "We couldn't find any results that matched your search criteria"