*** Settings ***
Library                 SeleniumLibrary
Library                 Collections

Documentation           Suite description #automated tests for scout website
Resource                ../Keywords/Common.robot
Test Setup              Run Keywords    Open Login Page     Log In To System    Click Add Player Link
Test Teardown           Close Browser

*** Variables ***
${ADDPLAYERLINK}        xpath=//main/div[count(div) = 3]/div[2]//a
${PLAYERNAMEFIELD}      xpath=//input[@name='name']
${PLAYERSURNAMEFIELD}   xpath=//input[@name='surname']
${PLAYERAGEFIELD}       xpath=//input[@name='age']
${PLAYERPOSITIONFIELD}  xpath=//input[@name='mainPosition']
${SUBMITPLAYERBTN}      xpath=//button[@type='submit']
${CLEARFIELDSBTN}       xpath=//button[@type='submit']/following-sibling::button
${PLAYERHEADER}         xpath=//form/div[contains(@class, 'MuiCardHeader-root')]
${TESTPLAYERNAME}       TEST ROBOT NAME
${TESTPLAYERSURNAME}    TEST ROBOT SURNAME
${TESTPLAYERAGE}        18.03.1998
${TESTPLAYERPOSITION}   Test Robot Position

*** Test Cases ***
Add player success
    [Tags]    Positive
    Type In Name
    Type In Surname
    Type In Age
    Type In Position
    Click Submit Player Button
    Assert Edit Page

Add player without required data
    [Tags]    Negative
    Type In Name
    Type In Age
    Click Submit Player Button
    Assert Stay At Add Page

Clear player form fields
    [Tags]    Positive
    Type In Name
    Type In Surname
    Type In Age
    Type In Position
    Click Clear Fields Button
    Assert Fields Are Empty

*** Keywords ***
Click add player link
    Click Element                  ${ADDPLAYERLINK}
    Wait Until Element Is Visible  ${PLAYERHEADER}
Type in name
    Input Text                     ${PLAYERNAMEFIELD}   ${TESTPLAYERNAME}
Type in surname
    Input Text                     ${PLAYERSURNAMEFIELD}    ${TESTPLAYERSURNAME}
Type in age
    Input Text                     ${PLAYERAGEFIELD}   ${TESTPLAYERAGE}
Type in position
    Input Text                     ${PLAYERPOSITIONFIELD}   ${TESTPLAYERPOSITION}
Click submit player button
    Click Element                  ${SUBMITPLAYERBTN}
Click clear fields button
    Click Element                  ${CLEARFIELDSBTN}


Assert stay at add page
    Title Should Be                Add player
    Capture Page Screenshot        screenshots/add_player_without_data.png

Assert edit page
    Wait Until Element Contains    ${PLAYERHEADER}  Edit player
    Title Should Be                Edit player ${TESTPLAYERNAME} ${TESTPLAYERSURNAME}
    Capture Page Screenshot        screenshots/edit_page_with_new_player.png

Assert fields are empty
    @{inputs}=                     Get Webelements        xpath=//form//input

    FOR    ${input}  IN  @{inputs}
        ${value}=   Get Element Attribute     ${input}  value
        Should Be Empty      ${value}
    END

    Capture Page Screenshot        screenshots/fields_are_empty.png

