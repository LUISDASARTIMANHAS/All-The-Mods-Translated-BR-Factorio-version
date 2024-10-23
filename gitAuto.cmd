:: Inicializa o repositório Git (se necessário)
if not exist ".git" (
    git init
    git remote add origin https://github.com/LUISDASARTIMANHAS/All-The-Mods-Translated-BR-Factorio-version.git
)

:: Verifica o status dos arquivos
git status

:: Adiciona todos os arquivos alterados, respeitando o .gitignore
git add .

:: Cria um commit com uma mensagem baseada no nome e versão do mod
git commit -m "Automated commit for %MOD_NAME% version %MOD_VERSION%"

:: Envia os arquivos para o repositório remoto na branch especificada
git push origin All-The-Mods-Translated-BR-LTN-Pack