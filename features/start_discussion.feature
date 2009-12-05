@discuss @editor
Feature: Start a discussion
  In order to start a proper discussion
  As an editor
  I want to create questions and add proposals to it

  # Firstly do it unpublished...
  @ok
  Scenario: Create a valid question as an editor
    Given there are no questions
      And I am logged in as "editor" with password "true"
      And I am on the Discuss Index
    When I follow "echonomyJAM"
      And I follow "Create a new Question"
      And I fill in the following:
        | title | Is this a Question?   |
        | text  | Blablabla bla bla bla |
      And I select "new" from "state"
      And I press "Save"
    Then I should see "Is this a Question?"
     And there should be one question

  @ok
  Scenario: Publish a question i created as an editor
    Given I am logged in as "editor" with password "true"
      And a "new" question in "echonomyJAM"
      And I am on the Discuss Index
    When I go to the question
      And I follow "edit" within "#summary"
      And I select "published" from "state"
      And I press "Save"
    Then the question should be published

  @ok
  Scenario: Create an invalid question as an editor
    Given there are no questions
      And I am logged in as "editor" with password "true"
    When I go to create a question
      And I fill in the following:
        | text | Blablabla bla bla bla |
      And I press "Save"
    # Todo: Maybe we should check the content of the error box as well
    Then there should be no questions
      And I should see an error message

  @ok
  Scenario: Add a proposal to a question as an editor (from ui)
    Given I am logged in as "editor" with password "true"
      And there is the first question
      And the question has no proposals
      And I am on the Discuss Index
    When I follow "echonomyJAM"
      And I choose the first Question
      And I follow "Create a new Proposal"
      And I fill in the following:
        | title | a proposal to propose some proposeworthy proposal data |
        | text  | nothing to propose yet...                              |
      And I press "Save"
    Then I should see "a proposal to propose some"
      And the question should have one proposal
      
  @allow-rescue
  Scenario: Create a valid question as a user
    Given there are no questions
     And I am logged in as "user" with password "true"
    When I go to create a question
    Then I should see an error message
