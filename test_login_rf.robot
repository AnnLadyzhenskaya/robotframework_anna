*** Settings ***
Library             SeleniumLibrary

Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}          Chrome
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}    xpath=//*[@id='password']
${SIGNINBUTTON}     xpath=//button[@type='submit']
${DASHBOARDLOGO}    xpath=//h6[text() = 'Scouts Panel']

*** Test Cases ***
Login to the system
    [Tags]    Debug
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert Dashboard
    [Teardown]    Close Browser


*** Keywords ***
Open login page
    Open Browser                   ${LOGIN URL}    ${BROWSER}
    Title Should Be                Scouts panel - sign in
Type in email
    Input Text                     ${EMAILINPUT}     user01@getnada.com
Type in password
    Input Text                     ${PASSWORDINPUT}  Test-1234
Click on the submit button
    Click Element                  ${SIGNINBUTTON}
Assert Dashboard
    Wait Until Element Is Visible  ${DASHBOARDLOGO}
    Title Should Be                Scouts panel
    Capture Page Screenshot        entered_to_dashboard.png

