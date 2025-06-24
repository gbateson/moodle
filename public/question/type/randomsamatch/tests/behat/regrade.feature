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
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user    | course | role           |
      | teacher | C1     | editingteacher |
      | student | C1     | student        |
    And the following "activities" exist:
      | activity | name   | course   | idnumber |
      | quiz     | Quiz 1 | C1       | Q1       |
    And the following "question categories" exist:
      | contextlevel    | reference | name                |
      | Activity module | Q1        | QuestionCategory Q1 |
    And the following "questions" exist:
      | questioncategory    | qtype       | name                    | template |
      | QuestionCategory Q1 | shortanswer | Short answer question A | frogtoad |
      | QuestionCategory Q1 | shortanswer | Short answer question B | frogtoad |
      | QuestionCategory Q1 | shortanswer | Short answer question C | frogtoad |

    # Create RSAM question in the Quiz.
    And I am on the "Quiz 1" "mod_quiz > Edit" page logged in as teacher
    And I add a "Random short-answer matching" question to the "Quiz 1" quiz with:
      | Category                      | QuestionCategory Q1 |
      | Question name                 | RSAM question name  |
      | Question text                 | RSAM question text  |
      | Default mark                  | 1                   |
      | Number of questions to select | 2                   |

  Scenario: Regrade a quiz containing a Random short-answer matching question without error
    # Student starts and finishes an attempt at the Quiz.
    When user "student" has started an attempt at quiz "Quiz 1"
    And user "student" has finished an attempt at quiz "Quiz 1"
    # Teacher regrades the Quiz.
    When I am on the "Quiz 1" "quiz activity" page logged in as teacher
    And I click on "Attempts: 1" "link"
    And I click on "Regrade attempts..." "button"
    And I click on "Dry run" "button"
    Then I should see "Regrade completed"
