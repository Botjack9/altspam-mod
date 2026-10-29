@echo off
title AltSpam Assist — Build
color 0D
echo.
echo  AltSpam Assist — Geode mod build
echo  ==================================
echo.

:: ── check for Geode CLI ──────────────────────────────────────────────────────
where geode >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERROR] Geode CLI not found.
    echo.
    echo  Install it from: https://geode-sdk.org/install
    echo  Then rerun this script.
    echo.
    start https://geode-sdk.org/install
    pause
    exit /b 1
)

for /f "tokens=*" %%v in ('geode --version 2^>^&1') do set GEODE_VER=%%v
echo  [OK] Geode CLI: %GEODE_VER%
echo.

:: ── build ─────────────────────────────────────────────────────────────────────
echo  [*] Building mod...
echo.
geode build

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Build failed. Check output above.
    echo.
    echo  Common fixes:
    echo    - Make sure Visual Studio 2022 with C++ workload is installed
    echo      (Geode CLI needs MSVC — it's the only part that does)
    echo    - Run: geode sdk install   (if Geode SDK not set up yet)
    echo    - Check mod.json has the right GD version
    pause
    exit /b 1
)

echo.
echo  ================================
echo   DONE
echo   .geode file is in build/
echo   Geode auto-installs it to GD
echo  ================================
echo.
echo  Launch Geometry Dash — the mod
echo  appears in the Geode mods list.
echo.
pause
