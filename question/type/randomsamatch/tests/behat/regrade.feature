@qtype @qtype_randomsamatch @javascript
Feature: Regrading random short-answer matching questions does not throw errors
  As a teacher
  In order to update student grades after changing a quiz setup
  I need to be able to regrade random short-answer matching questions without errors

  Background:
    Given the following "users" exist:
      | username |
      | teacher  |
      | student  |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | Course 1  | 0        |
    And the following "course enrolments" exist:
      | user    | course   | role           |
      | teacher | Course 1 | editingteacher |
      | student | Course 1 | student        |
    And the following "question categories" exist:
      | contextlevel | reference | name       |
      | Course       | Course 1  | Category 1 |
    And the following "questions" exist:
      | questioncategory | qtype       | name                    | template |
      | Category 1       | shortanswer | Short answer question A | frogtoad |
      | Category 1       | shortanswer | Short answer question B | frogtoad |
    And the following "activities" exist:
      | activity | name   | course   | idnumber |
      | quiz     | Quiz 1 | Course 1 | quiz1    |

  Scenario: Regrading a random short-answer matching question should not result in an error
    Given I log in as "teacher"
    And I add a "Random short-answer matching" question to the "Quiz 1" quiz with:
      | Question name | RSAM question |
      | Question text | Test          |
      | Default mark  | 1.0           |
    And user "student" has started an attempt at quiz "Quiz 1" randomised as follows:
      | slot | actualquestion          |
      | 1    | Short answer question A |
    When I am on the "Quiz 1" "quiz activity" page
    And I click on "Attempts: 1" "link"
    And I click on "Regrade attempts..." "button"
    And I click on "Dry run" "button"
    Then I should see "Regrade completed"
    And I should not see "The number of sub-questions has changed"
