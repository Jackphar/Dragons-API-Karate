@Regression
Feature: Create Account Test

  Background: Setup url and generate token
    * def result = callonce read('GenerateTokenTest.feature')
    * def token = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Primaray Account Test
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    Then request
      """
      {
      "email": "janjanijana@hotmail.com",
      "firstName": "jani",
      "lastName": "jani",
      "title": "Mrs.",
      "gender": "FEMALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "1985-07-02T00:10:02.474Z",
      "new": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == "janjanijana@hotmail.com"
    #delete the account
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = response.id
    And header Authorization = "Bearer " + token
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
