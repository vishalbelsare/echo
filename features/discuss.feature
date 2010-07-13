@discuss @UserSession
Feature: Take Part on a discussion
  In order to take part on a discussion
  As a user
  I want to give different kind of statements on questions


  # Within the discuss area the list of debates should be
  # correctly ordered (by date of creation)

  # FIXME this can't work in this way, and should anyway rather being tested inside a functional test

  Scenario: View debates list
     Given I am logged in as "user" with password "true"
     And I am on the Discuss Index
     When I follow "Featured"
     When I follow "echonomyJAM"
       When I choose the first Question
     And I am on the Discuss Index
     When I follow "Featured"
     When I follow "echonomyJAM"
       When I choose the second Question
     Then the second question must be more recent than the first question


  @ok
  Scenario: Open a question
    Given I am logged in as "user" with password "true"
      And I am on the Discuss Index
    When I follow "Featured"
    When I follow "echonomyJAM"
      And I choose the first Question
    Then I should see the questions title

  @ok
  Scenario: Add a proposal to a question
    Given I am logged in as "user" with password "true"
      And there is the first question
      And the question has no proposals
      And I am on the Discuss Index
    When I follow "Featured"
    When I follow "echonomyJAM"
      And I choose the first Question
      And I follow localized "discuss.statements.create_proposal_link"
      And I fill in the following:
        | proposal_statement_document_title | a proposal to propose some proposeworthy proposal data |
        | proposal_statement_document_text | nothing to propose yet...                              |
      And I press "Save"
      Then I should see "a proposal to propose some"
      And the question should have one proposal

  @ok
  Scenario: Add an Improvement Proposal to a Proposal
    Given I am logged in as "user" with password "true"
      And there is the first question
      And the question has at least on proposal
    When I go to the questions first proposal
      And I follow "create_improvement_proposal_link"
      And I fill in the following:
      | improvement_proposal_statement_document_title           | Improving the unimprovable                                           |
      | improvement_proposal_statement_document_text           | blubb (oh, and of cause a lot of foo and a little bit of (mars-)bar) |
      And I press "Save"
    Then I should see "Improving the unimprovable"
      And the proposal should have one improvement proposal

  @ok
  Scenario: Edit a proposal i created
    Given I am logged in as "user" with password "true"
      And there is a proposal I have created
      And the proposal was not published yet
     When I go to the proposal
     Then I should see "Edit"
      And I follow "Edit"
      And I fill in the following:
       | proposal_statement_document_title | my updated proposal               |
       | proposal_statement_document_text  | somewhat more to propose at lease |
      And I press "Save"
    Then I should see "my updated proposal"


# Open Questions:

# * should we always display in which other languages the statement might also exist, or always trust that the order of languages the user speaks is right"?
# ** Do we have an order of languages anyway? If the user can only use checkboxes for selecting languages she speaks, it's impossible to figure out more order than local language, other languages.
# In this case we should really display the user in what languages (he speaks) the statement has translations

# * what should i actually see when i navigate directly to a proposal without a translation into any language i speak (for example through an direct link?)

   Scenario: View a proposal
     Given I am logged in as "user" with password "true"
       And there is a proposal
     When I go to the proposal
     Then I should see localized "discuss.summary.title"
       And I should see the proposals data
       And I should see localized "discuss.statements.create_improvement_proposal_link"
       And I should see localized "discuss.statements.create_internal_link"

   Scenario: Question has only proposals in german, which will not be seen by a user with no defined german language
    Given I am logged in as "red" with password "red"
      And I am on the Discuss Index
    When I follow "Featured"
    When I follow "echonomyJAM"
      And I choose the "I only have kids in German" Question
      And the question has proposals
      Then I should see no proposals

