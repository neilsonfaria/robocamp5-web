*** Settings ***
Documentation       Este arquivo implementa funções e elementos da página login

*** Keywords ***
Login With
    [Arguments]     ${email}       ${pass}

    Input Text       id:emailId    ${email}
    Input Text       id:passId     ${pass}
    Click Element    class:btn