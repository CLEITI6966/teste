# Autoelevação
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {

    Write-Host "Reiniciando o script como administrador..." -ForegroundColor Yellow
    Start-Process powershell -Verb runAs -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`"")
    exit
}

$regPath = Join-Path $PSScriptRoot "reg"

# Verifica se a pasta existe
if (-not (Test-Path $regPath)) {
    Write-Host "[ERRO] Pasta 'reg' não encontrada." -ForegroundColor Red
    exit 1
}

# Pega todos os arquivos .reg
$regFiles = Get-ChildItem -Path $regPath -Filter *.reg

if ($regFiles.Count -eq 0) {
    Write-Host "[INFO] Nenhum arquivo .reg encontrado na pasta 'reg'." -ForegroundColor Yellow
    exit 0
}

foreach ($file in $regFiles) {
    $filePath = $file.FullName
    Write-Host "Aplicando: $($file.Name)" -ForegroundColor Cyan
    try {
        Start-Process -FilePath "regedit.exe" -ArgumentList "/s `"$filePath`"" -Wait
    } catch {
        Write-Host "[ERRO] Falha ao aplicar $($file.Name)" -ForegroundColor Red
    }
}

Write-Host "`nTodos os arquivos .reg foram aplicados." -ForegroundColor Green
