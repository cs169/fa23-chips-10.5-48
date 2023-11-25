Feature: Login via Google and Github

Scenario: Login through Google
  Given I am on the login page
  Then I should see "Sign in with Google"
  Then I press "Sign in with Google"

Scenario: Login through GitHub
  Given I am on the login page
  Then I should see "Sign in with GitHub"
  Then I press "Sign in with GitHub"
