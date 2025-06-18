# configurar_dns_cloudflare.ps1

# Define os servidores DNS da Cloudflare
$dnsServers = @("1.1.1.1", "1.0.0.1")

# Pega todas as interfaces IPv4 ativas
$adapters = Get-DnsClientServerAddress | Where-Object {
    $_.AddressFamily -eq "IPv4" -and $_.InterfaceOperationalStatus -eq "Up"
}

# Configura o DNS para cada interface
foreach ($adapter in $adapters) {
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses $dnsServers
}

Write-Output "DNS Cloudflare (1.1.1.1 e 1.0.0.1) configurados com sucesso!"
