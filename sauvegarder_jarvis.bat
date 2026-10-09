@echo off
title Sauvegarder Jarvis
rem Envoie tes dernieres modifications sur GitHub en un clic :
rem ajoute tout, cree un commit date, puis pousse. Les fichiers sensibles
rem (reglages_local.py, memoire.json, voix...) restent exclus via .gitignore.
cd /d "%~dp0"

where git >nul 2>&1
if errorlevel 1 (
    echo ============================================
    echo   Git n'est pas installe ou introuvable
    echo ============================================
    echo.
    echo Installez Git puis relancez ce script.
    echo   https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ============================================
    echo   Le dossier n'est pas un depot Git
    echo ============================================
    echo.
    echo Ouvre le projet Jarvis depuis un dossier clone de GitHub.
    echo.
    pause
    exit /b 1
)

echo ============================================
echo   Sauvegarde de Jarvis sur GitHub
echo ============================================
echo.

git add -A

rem S'il n'y a rien de nouveau, on s'arrete proprement.
git diff --cached --quiet
if not errorlevel 1 (
    echo Rien de nouveau a sauvegarder. Tout est deja a jour.
    echo.
    pause
    exit /b 0
)

git commit -m "Sauvegarde du %DATE% %TIME%"
if errorlevel 1 goto erreur

echo.
echo Envoi vers GitHub...
git push
if errorlevel 1 goto erreur

echo.
echo Sauvegarde terminee avec succes.
echo.
pause
exit /b 0

:erreur
echo.
echo Echec de la sauvegarde.
echo Verifiez votre connexion internet, les identifiants GitHub, et la remote du projet.
echo Tes fichiers locaux sont intacts. Tu peux reessayer plus tard.
echo.
pause
exit /b 1
