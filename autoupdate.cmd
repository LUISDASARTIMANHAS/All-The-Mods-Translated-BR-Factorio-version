@echo off
setlocal enabledelayedexpansion

:: Carrega as variáveis do arquivo .env
if exist .env (
    for /f "tokens=* delims=" %%i in (.env) do (
        set "%%i"
    )
)

:: Verifica se a chave de API foi carregada
if "%API_KEY%"=="" (
    echo Erro: A chave de API nao foi carregada do arquivo .env.
    exit /b 1
)

:: Configurações do script
set MOD_NAME="All-The-Mods-Translated-BR"
set MOD_VERSION=0.0.34
set ZIP_FILE=%MOD_NAME%_%MOD_VERSION%.zip

:: Remove qualquer arquivo ZIP anterior com o mesmo nome
if exist "%ZIP_FILE%" (
    del "%ZIP_FILE%"
)

:: Compacta todos os arquivos na pasta atual em um arquivo ZIP, excluindo .env e outros arquivos indesejados
echo Compactando o mod em %ZIP_FILE%...
tar -a -c -f "%ZIP_FILE%" --exclude=".env" --exclude="*.cmd" --exclude=".gitignore" --exclude="*.zip" --exclude="*.git" .

:: Verifica se o arquivo ZIP foi criado com sucesso
if not exist "%ZIP_FILE%" (
    echo Erro: Falha ao criar o arquivo ZIP.
    exit /b 1
)

:: Publica o mod no Factorio
echo Publicando o mod no Factorio...
curl -X POST ^
     -F "file=@%ZIP_FILE%" ^
     -F "name=%MOD_NAME%" ^
     -F "version=%MOD_VERSION%" ^
     -H "Authorization: Token %API_KEY%" ^
     https://mods.factorio.com/api/v2/mods/init_publish

:: Verifica o código de retorno do cURL
if errorlevel 1 (
    echo Erro: Falha ao publicar o mod.
    exit /b 1
)

echo Mod publicado com sucesso!
exit /b 0