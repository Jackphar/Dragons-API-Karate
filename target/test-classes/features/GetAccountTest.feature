@Regression
Feature: Get Account Test

  Background: Setup
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token

  Scenario: Get Account API Test
    Given path "/api/accounts/get-account"
    And param primaryPersonId = 9226
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == 9226
    And assert response.primaryPerson.email == "Kamran@yahoo.com"