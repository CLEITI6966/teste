# === Ativa o plano de energia de alto desempenho ===
Start-Process -FilePath "powercfg.exe" -ArgumentList "/setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" -WindowStyle Hidden -Wait

# === Baixa a imagem de papel de parede ===
$imageUrl = "https://images.pexels.com/photos/1072179/pexels-photo-1072179.jpeg?cs=srgb&dl=pexels-catiamatos-1072179.jpg&fm=jpg"
$outputPath = "$env:TEMP\wallpaper_original.jpeg"
Invoke-WebRequest -Uri $imageUrl -OutFile $outputPath -UseBasicParsing

# === Redimensiona e aplica o papel de parede ===
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$img = [System.Drawing.Image]::FromFile($outputPath)

$scale = [Math]::Max($screen.Width / $img.Width, $screen.Height / $img.Height)
$newW = [int]($img.Width * $scale)
$newH = [int]($img.Height * $scale)

$bmp = New-Object System.Drawing.Bitmap $screen.Width, $screen.Height
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = 'HighQualityBicubic'
$g.Clear([System.Drawing.Color]::Black)

$offsetX = -1 * [int](($newW - $screen.Width) / 2)
$offsetY = -1 * [int](($newH - $screen.Height) / 2)
$g.DrawImage($img, $offsetX, $offsetY, $newW, $newH)

$finalWallpaper = "$env:TEMP\wallpaper.jpeg"
$bmp.Save($finalWallpaper, [System.Drawing.Imaging.ImageFormat]::Jpeg)

$code = '[DllImport("user32.dll")] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);'
Add-Type -MemberDefinition $code -Name NativeMethods -Namespace Win32
[Win32.NativeMethods]::SystemParametersInfo(20, 0, $finalWallpaper, 3)

# === Ativa o modo escuro (Sistema + Apps) ===
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Value 0

# === Configura DNS da Cloudflare ===
$dnsServers = @("1.1.1.1", "1.0.0.1")
$adapters = Get-DnsClientServerAddress | Where-Object {
    $_.AddressFamily -eq "IPv4" -and $_.InterfaceOperationalStatus -eq "Up"
}
foreach ($adapter in $adapters) {
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses $dnsServers
}

# === Baixa e extrai o tema de cursor ===
$cursorZipUrl = "https://download1529.mediafire.com/61rau8t7mjlgCPj-8Fkyxx9VmMKi2v41u_0_jn5TlYGHzRss5tGvfQS9Yk3es_LGapXO6pRsFoTcqwebWlkMteDe-1vAWZGhIh5ExJtxWHPhdUkfGk_C2Hn33LLmEHOLxcnAxgmgMCq8JYsalibOXExG1y1gvDSw5ATx-lhwJcM78o_E/ek4jgzcsi632emv/cursor.zip"
$zipPath = "$env:TEMP\cursor.zip"
$extractPath = "C:\cursor\dark"

Invoke-WebRequest -Uri $cursorZipUrl -OutFile $zipPath -UseBasicParsing
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# === Aplica tema de cursor personalizado ===
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Arrow" -Value "$extractPath\arrow.cur"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Help" -Value "$extractPath\help.cur"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "AppStarting" -Value "$extractPath\appstarting.ani"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Wait" -Value "$extractPath\appstarting.ani"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Crosshair" -Value "$extractPath\crosshair.cur"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "IBeam" -Value "$extractPath\ibeam.cur"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "NWPen" -Value "$extractPath\nwpen.cur"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "No" -Value "$extractPath\no.cur"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Hand" -Value "$extractPath\hand.cur"
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Person" -Value "$extractPath\person.cur"

# Aplica as alterações no cursor
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

Write-Output "✅ Configuração finalizada com sucesso: DNS, papel de parede, modo escuro, energia e cursor aplicado."
