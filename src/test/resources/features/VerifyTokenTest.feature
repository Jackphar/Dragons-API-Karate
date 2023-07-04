@Smoke @Regression
Feature: Verify Token Test

  Background: Setup
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  Scenario: Verify Valid Token
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response
    And assert response == "true"

  Scenario: Verify Valid Token with wrong username
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "WrongUsername"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  Scenario: Verify Token with valid username and invalid token
    Given path "/api/token/verify"
    And param token = "invalid Token"
    And param username = "supervisor"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
