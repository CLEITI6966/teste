@echo off
setlocal
title Instalador Completo - DNS, Programas e Registro
color 0A

:: === Desativa o UAC ===
echo Criando arquivo para desativar o UAC...
> "%temp%\desativar_uac.reg" echo Windows Registry Editor Version 5.00
>> "%temp%\desativar_uac.reg" echo.
>> "%temp%\desativar_uac.reg" echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
>> "%temp%\desativar_uac.reg" echo "EnableLUA"=dword:00000000

echo Aplicando modificacao no registro para desativar o UAC...
reg import "%temp%\desativar_uac.reg"

:: Verifica a conectividade com raw.githubusercontent.com
powershell -Command "try { iwr https://raw.githubusercontent.com -UseBasicParsing -TimeoutSec 5 | Out-Null; exit 0 } catch { exit 1 }"
if %errorlevel% neq 0 (
    echo ERRO: Sem acesso ao site raw.githubusercontent.com. Verifique sua internet ou firewall.
    pause
    exit /b
)

:: Baixa o script reg.ps1 e executa
echo Baixando reg.ps1...
powershell -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/CLEITI6966/teste/refs/heads/main/reg.ps1' -OutFile reg.ps1"
if not exist reg.ps1 (
    echo ERRO: Falha ao baixar reg.ps1
    pause
    exit /b
)
powershell -NoProfile -ExecutionPolicy Bypass -File reg.ps1

:: Baixa o script dns.ps1 e executa
echo Baixando dns.ps1...
powershell -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/CLEITI6966/teste/refs/heads/main/dns.ps1' -OutFile dns.ps1"
if not exist dns.ps1 (
    echo ERRO: Falha ao baixar dns.ps1
    pause
    exit /b
)
powershell -NoProfile -ExecutionPolicy Bypass -File dns.ps1

call :loading

:: Verifica se o winget existe antes de continuar
where winget >nul 2>&1
if errorlevel 1 (
    echo ERRO: O winget nao esta instalado neste sistema.
    echo Baixe pela Microsoft Store: https://aka.ms/getwinget
    pause
    exit /b
)

echo.
echo Processo concluido. Pressione qualquer tecla para sair.
pause >nul
exit /b

:loading
echo Aguarde, carregando...
timeout /t 3 >nul
goto :eof
