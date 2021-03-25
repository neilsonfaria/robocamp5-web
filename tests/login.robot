*** Settings ***
Documentation    Login
...              Sendo um administrador de catálogo
...              Quero me autenticar no sistema
...              Para que eu possa gerenciar o catálogo de produtos

Resource    ../resources/actions.robot

# Ganho que é executa toda vez que um Caso de teste termina
Suite Setup     Open Session
Suite Teardown  Close Session

Test Teardown   After Test

*** Test Cases ***
Login com sucesso
    [tags]     login
    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "papito@ninjapixel.com" e "pwd123"
    Entao devo ser autenticado

    [Teardown]      After Test WCLS

Senha incorreta
    [Template]               Tentativa de login com mensagem de erro
    papito@ninjapixel.com    abc123                Usuário e/ou senha inválidos

Email não existe
    [Template]    Tentativa de login com mensagem de erro
    404@yahoo     abc123                Usuário e/ou senha inválidos

Email Obrigatório
    [Template]    Tentativa de login com mensagem informativa
    ${EMPTY}      abc123                Opps. Informe o seu email!

Senha Obrigatória
    [Template]               Tentativa de login com mensagem informativa
    papito@ninjapixel.com    ${EMPTY}              Opps. Informe a sua senha!

*** Keywords ***
Tentativa de login com mensagem de erro
    [Arguments]    ${email}    ${pass}    ${saida}

    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Entao devo ver uma mensagem de erro     ${saida}

Tentativa de login com mensagem informativa
    [Arguments]    ${email}    ${pass}    ${saida}

    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Entao devo ver uma mensagem informativa     ${saida}