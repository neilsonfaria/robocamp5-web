

***Variables***
@{Nomes}      Papito      João        Will

***Test Cases***
Testando uma Lista
    : FOR   ${nome}     IN      @{Nomes}
    
    \   Log To Console      ${nome}
