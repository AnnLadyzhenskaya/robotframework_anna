*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}          Chrome
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}    xpath=//*[@id='password']
${SIGNINBUTTON}     xpath=//button[@type='submit']
${DASHBOARDLOGO}    xpath=//h6[text() = 'Scouts Panel']

*** Keywords ***
Open login page
    Open Browser                   ${LOGIN URL}    ${BROWSER}
    Title Should Be                Scouts panel - sign in
Log in to system
    Input Text                     ${EMAILINPUT}     user01@getnada.com
    Input Text                     ${PASSWORDINPUT}  Test-1234
    Click Element                  ${SIGNINBUTTON}
    Wait Until Element Is Visible  ${DASHBOARDLOGO}
    Title Should Be                Scouts panel