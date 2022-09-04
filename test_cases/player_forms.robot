*** Settings ***
Library                 SeleniumLibrary
Library                 Collections

Documentation           Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}            https://scouts-test.futbolkolektyw.pl/en
${BROWSER}              Chrome
${EMAILINPUT}           xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${SIGNINBUTTON}         xpath=//button[@type='submit']
${DASHBOARDLOGO}        xpath=//h6[text() = 'Scouts Panel']
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
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Dashboard
    Click Add Player Link
    Type In Name
    Type In Surname
    Type In Age
    Type In Position
    Click Submit Player Button
    Assert Edit Page
    [Teardown]    Close Browser

Add player without required data
    [Tags]    Negative
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Dashboard
    Click Add Player Link
    Type In Name
    Type In Age
    Click Submit Player Button
    Assert Stay At Add Page
    [Teardown]    Close Browser

Clear player form fields
    [Tags]    Positive
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Dashboard
    Click Add Player Link
    Type In Name
    Type In Surname
    Type In Age
    Type In Position
    Click Clear Fields Button
    Assert Fields Are Empty
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
    Capture Page Screenshot        add_player_without_data.png

Assert edit page
    Wait Until Element Contains    ${PLAYERHEADER}  Edit player
    Title Should Be                Edit player ${TESTPLAYERNAME} ${TESTPLAYERSURNAME}
    Capture Page Screenshot        edit_page_with_new_player.png

Assert fields are empty
    @{inputs}=                     Get Webelements        xpath=//form//input

    FOR    ${input}  IN  @{inputs}
        ${value}=   Get Element Attribute     ${input}  value
        Should Be Empty      ${value}
    END

    Capture Page Screenshot        fields_are_empty.png

