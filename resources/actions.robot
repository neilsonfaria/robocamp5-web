*** Settings ***
Documentation    Actions é o arquivo que terá keywords que implementam os steps

Library    libs/db.py
Library    SeleniumLibrary
Library    OperatingSystem

Resource    pages/BasePage.robot
Resource    pages/Sidebar.robot
Resource    pages/LoginPage.robot
Resource    pages/ProductPage.robot

*** Keywords ***
### Helpers
Get Product Json
    [Arguments]     ${file_name}

    ${file}=    Get File    resources/fixtures/${file_name}
    ${json}=    Evaluate    json.loads($file)          json

    [return]    ${json}

### Login
Dado que eu acesso a página de login
    Go To      ${base_url}/login 

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Login With    ${email}    ${pass}

Entao devo ser autenticado
    # Checkpoint
    Wait Until Element Is Visible    ${LOGGED_USER}
    Element Text Should Be           ${LOGGED_USER}    Papito

Entao devo ver uma mensagem de erro
    [Arguments]         ${expect_message}

     Wait Until Element Contains    ${ALERT_DANGER}    ${expect_message}

Entao devo ver uma mensagem informativa
    [Arguments]         ${expect_message}

    Wait Until Element Contains    ${ALERT_INFO}    ${expect_message}

## Products
Dado que eu tenho um novo produto
    [Arguments]     ${file_name}

    ${product_json}=    Get Product Json      ${file_name}  

    Remove Product By Name    ${product_json['name']}
    Set Test Variable         ${product_json}

Mas este produto já foi cadastrado
    Go To Product Form
    Create New Product        ${product_json}

Quando eu faço o cadastro desse produto
    Go To Product Form
    Create New Product        ${product_json}

Quando eu tento cadastrar o produto
    Create New Product        ${product_json}
   
Então devo ver este item no catálogo
    # Então no BDD é o Checkpoint
    Table Should Contain    class:table    ${product_json['name']}

### Remover
Dado que eu tenho o produto "${file_name}" no catálogo
    # aqui estamos criando um produto destinado a ser removido
    ${product_json}=    Get Product Json      ${file_name}  

    Remove Product By Name    ${product_json['name']}
    Go To Product Form
    Create New Product        ${product_json}

    Set Test Variable         ${product_json}

Quando solicito a exclusão
    Click Element   xpath://tr[td//text()[contains(., '${product_json['name']}')]]//button
    Wait Until Element Is Visible   class:swal2-modal

E confirmo a solicitação
    Click Element   class:swal2-confirm

Mas cancelo a solicitação
    Click Element   class:swal2-cancel

Então não devo ver este item no catálogo
    Wait Until Element Does Not Contain    class:table    ${product_json['name']}