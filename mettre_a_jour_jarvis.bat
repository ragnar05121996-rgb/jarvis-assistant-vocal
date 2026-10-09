@echo off
title Mise a jour de Jarvis
rem Met a jour les bibliotheques Python du projet vers leurs dernieres
rem versions compatibles, puis synchronise l'environnement. A lancer
rem quand on le souhaite (pas a chaque demarrage : une nouvelle version
rem peut demander internet et parfois casser quelque chose).
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
        echo Installez UV avant de relancer ce script :
        echo   https://docs.astral.sh/uv/getting-started/installation/
        echo.
        echo Ou ouvrez une console PowerShell puis lancez :
        echo   powershell -ExecutionPolicy Bypass -c "irm https://astral.sh/uv/install.ps1 | iex"
        echo.
        pause
        exit /b 1
    )
)

echo ============================================
echo   Mise a jour des dependances de Jarvis
echo ============================================
echo.

echo [1/2] Mise a jour du lockfile...
"%UV_CMD%" lock --upgrade
if errorlevel 1 goto erreur

echo.
echo [2/2] Synchronisation de l'environnement...
"%UV_CMD%" sync
if errorlevel 1 goto erreur

echo.
echo Mise a jour terminee. Vous pouvez relancer Jarvis.
echo.
pause
exit /b 0

:erreur
echo.
echo Echec de la mise a jour.
echo Verfiez votre connexion internet, la presence de Python 3.13, et la compatibilite des versions.
echo Si le probleme persiste, relancez manuellement :
echo   "%UV_CMD%" lock --upgrade
echo   "%UV_CMD%" sync
echo.
pause
exit /b 1