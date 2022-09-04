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
${SIGNOUTBUTTON}    xpath=//ul[2]/div[@role='button'][2]
${LANGUAGEBUTTON}   xpath=//ul[2]/div[@role='button'][1]
${MAINPAGEBUTTON}   xpath=//ul[1]/div[@role='button'][1]
${MAINPAGETEXT}
${CHANGEDTEXT}

*** Test Cases ***

Sign out of system
    [Tags]    Debug
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Dashboard
    Click On The Sign Out Button
    Assert Login Page
    [Teardown]    Close Browser

Change language of page
    [Tags]    Debug
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Dashboard
    Detect Language Of Page
    Click On The Language Button
    Assert Language Changed
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


Click on the sign out button
    Click Element                  ${SIGNOUTBUTTON}
Assert login page
    Title Should Be                Scouts panel - sign in
    Capture Page Screenshot        logout_passed.png

Detect language of page
    ${main_button_text}=           Get Text    ${MAINPAGEBUTTON}
    Set Global Variable            ${MAINPAGETEXT}    ${main_button_text}
    Log To Console                 DETECTED MAINPAGETEXT: "${MAINPAGETEXT}"

Click on the language button
    Click Element                  ${LANGUAGEBUTTON}
Assert language changed
    ${main_button_text}=           Get Text    ${MAINPAGEBUTTON}
    Set Global Variable            ${CHANGEDTEXT}  ${main_button_text}
    Should Not Be Equal            ${MAINPAGETEXT}    ${CHANGEDTEXT}
    Log To Console                 "MAINPAGETEXT: ${MAINPAGETEXT}"
    Log To Console                 "CHANGEDTEXT: ${CHANGEDTEXT}"