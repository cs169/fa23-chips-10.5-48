Feature: View events

Scenario: See events
  Given I am on the events page
  Then I should see "Add New Event"
  When I follow "Add New Event"


 Scenario: Directly access links
  When I visit profile "p"
  When I create event "p"
