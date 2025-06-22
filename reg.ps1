# Autoelevação
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {

    Write-Host "Reiniciando o script como administrador..." -ForegroundColor Yellow
    Start-Process powershell -Verb runAs -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`"")
    exit
}

$regPath = Join-Path $PSScriptRoot "reg"
$zipUrl = "https://github.com/CLEITI6966/teste/raw/refs/heads/main/reg.zip"
$zipPath = Join-Path $PSScriptRoot "reg.zip"

# Baixar e extrair o arquivo reg.zip se a pasta reg não existir
if (-not (Test-Path $regPath)) {
    Write-Host "Baixando arquivo reg.zip..." -ForegroundColor Cyan
    try {
        # Usando WebClient para baixar o arquivo
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($zipUrl, $zipPath)
        
        Write-Host "Extraindo arquivo..." -ForegroundColor Cyan
        # Extrair o arquivo zip
        Expand-Archive -Path $zipPath -DestinationPath $PSScriptRoot -Force
        
        # Remover o arquivo zip após extrair (opcional)
        Remove-Item $zipPath -Force
        
        Write-Host "Arquivo reg.zip baixado e extraído com sucesso." -ForegroundColor Green
    } catch {
        Write-Host "[ERRO] Falha ao baixar ou extrair o arquivo reg.zip" -ForegroundColor Red
        Write-Host "Erro: $_" -ForegroundColor Red
        exit 1
    }
}

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
