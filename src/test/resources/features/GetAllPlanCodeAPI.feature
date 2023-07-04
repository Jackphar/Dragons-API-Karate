@Regression
Feature: Get All Plan Code

  Background: Setup API test
    * def result = callonce read('GenerateTokenTest.feature')
    * def token = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get All Plan Code Test
    And path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
    And assert response[0].planExpired == false
    And assert response[1].planExpired == false
    And assert response[2].planExpired == false
    And assert response[3].planExpired == false
