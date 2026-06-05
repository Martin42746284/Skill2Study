@echo off
REM Development startup script for Windows

setlocal enabledelayedexpansion

echo.
echo ============================================================
echo ^>^> Demarrage de la plateforme d'orientation universitaire...
echo ============================================================
echo.

REM Check if docker-compose is available
docker-compose --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Verification de PostgreSQL avec Docker...
    docker ps | findstr postgres >nul 2>&1
    if %errorlevel% equ 0 (
        echo [OK] PostgreSQL est deja en cours d'execution
    ) else (
        echo [INFO] Demarrage de PostgreSQL via Docker...
        docker-compose up -d
        timeout /t 5 /nobreak
    )
) else (
    echo [WARNING] Docker n'est pas disponible. Assurez-vous que PostgreSQL est en local.
)

REM Backend
echo.
echo [INFO] Configuration du backend...
cd backend

if not exist "node_modules\" (
    echo [INFO] Installation des dependances backend...
    call npm install
)

if not exist ".env" (
    echo [INFO] Creation du fichier .env...
    copy .env.example .env
)

echo [INFO] Initialisation de la base de donnees...
call npm run seed >nul 2>&1

echo [INFO] Demarrage du serveur backend sur le port 5000...
start "Backend Server" cmd /k npm run dev

cd ..

REM Frontend
echo.
echo [INFO] Configuration du frontend...

if not exist "node_modules\" (
    echo [INFO] Installation des dependances frontend...
    call npm install
)

echo [INFO] Demarrage du serveur frontend sur le port 5173...
start "Frontend Server" cmd /k npm run dev

REM Show information
echo.
echo ============================================================
echo ^>^> Plateforme demarree avec succes!
echo ============================================================
echo.
echo     Frontend  : http://localhost:5173
echo     Backend   : http://localhost:5000
echo     API Docs  : http://localhost:5000/api/docs
echo.
echo Comptes de test :
echo   admin@orientation.dz / Admin1234! (Admin)
echo   marie.dupont@example.com / Password123! (Bachelier)
echo   karim.ahmed@example.com / Password123! (Bachelier)
echo.
echo Appuyez sur Ctrl+C pour arreter les serveurs.
echo ============================================================
echo.

REM Keep the window open
pause

endlocal
