@echo off
title Serveur MCP Jarvis
rem Lance le serveur MCP de Jarvis en mode HTTP (serveur autonome : les clients
rem MCP distants s'y connectent). Pour Claude Desktop en local, pas besoin de ce
rem raccourci : Claude Desktop lance le serveur lui-meme (stdio). Voir docs/mcp.md.
cd /d "%~dp0"

set "UV_CMD=%USERPROFILE%\.local\bin\uv.exe"
if not exist "%UV_CMD%" (
    where uv >nul 2>&1
    if not errorlevel 1 (
        set "UV_CMD=uv"
    ) else (
        echo ============================================
        echo   UV n'est pas installe ou introuvable
        echo ============================================
        echo.
        echo Installez UV avant de lancer le serveur MCP :
        echo   https://docs.astral.sh/uv/getting-started/installation/
        echo.
        echo Ou ouvrez une console PowerShell puis lancez :
        echo   powershell -ExecutionPolicy Bypass -c "irm https://astral.sh/uv/install.ps1 | iex"
        echo.
        pause
        exit /b 1
    )
)

git pull --ff-only 2>nul
set JARVIS_MCP_TRANSPORT=http
"%UV_CMD%" run python -m jarvis.mcp_server
echo.
echo Le serveur MCP s'est arrete. Vous pouvez fermer cette fenetre.
pause
