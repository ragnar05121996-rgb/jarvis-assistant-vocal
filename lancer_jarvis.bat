@echo off
title Jarvis
rem Lanceur de l'assistant vocal. Se place dans le dossier du projet puis
rem demarre jarvis14.py via uv. Chemin absolu vers uv pour fonctionner
rem aussi au demarrage de Windows, ou le PATH peut differer.
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
        echo Installez UV avant de lancer Jarvis :
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
"%UV_CMD%" run python jarvis14.py
echo.
echo Jarvis s'est arrete. Vous pouvez fermer cette fenetre.
pause
