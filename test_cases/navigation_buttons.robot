*** Settings ***
Library             SeleniumLibrary

Documentation       Suite description #automated tests for scout website
Resource            ../Keywords/Common.robot
Test Setup          Run Keywords    Open Login Page     Log In To System
Test Teardown       Close Browser

*** Variables ***
${SIGNOUTBUTTON}    xpath=//ul[2]/div[@role='button'][2]
${LANGUAGEBUTTON}   xpath=//ul[2]/div[@role='button'][1]
${MAINPAGEBUTTON}   xpath=//ul[1]/div[@role='button'][1]
${MAINPAGETEXT}
${CHANGEDTEXT}

*** Test Cases ***

Sign out of system
    [Tags]    Debug
    Click On The Sign Out Button
    Assert Login Page

Change language of page
    [Tags]    Debug
    Detect Language Of Page
    Click On The Language Button
    Assert Language Changed


*** Keywords ***
Click on the sign out button
    Click Element                  ${SIGNOUTBUTTON}
Assert login page
    Title Should Be                Scouts panel - sign in
    Capture Page Screenshot        screenshots/logout_passed.png

Detect language of page
    ${main_button_text}=           Get Text    ${MAINPAGEBUTTON}
    Set Global Variable            ${MAINPAGETEXT}    ${main_button_text}
    Capture Element Screenshot     ${MAINPAGEBUTTON}  screenshots/detected_language.png

Click on the language button
    Click Element                  ${LANGUAGEBUTTON}
Assert language changed
    ${main_button_text}=           Get Text    ${MAINPAGEBUTTON}
    Set Global Variable            ${CHANGEDTEXT}  ${main_button_text}
    Should Not Be Equal            ${MAINPAGETEXT}    ${CHANGEDTEXT}
    Log To Console                 "MAINPAGETEXT: ${MAINPAGETEXT}"
    Log To Console                 "CHANGEDTEXT: ${CHANGEDTEXT}"
    Capture Element Screenshot     ${MAINPAGEBUTTON}  screenshots/changed_language.png