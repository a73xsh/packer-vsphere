function Get-TS { return "{0:HH:mm:ss}" -f [DateTime]::Now }

Import-Module 'C:\Program Files (x86)\Microsoft SQL Server\130\Tools\PowerShell\Modules\SQLPS\SQLPS.PS1'

Write-Output "$(Get-TS): Extract files"
Expand-Archive 'C:\vbr_temp\vbr_files.zip' -DestinationPath 'C:\vbr_temp\'
###Configure VBR

#Connect VBR
Connect-VBRServer -Server $env:COMPUTERNAME
$VBRServer = Get-VBRServer -Name $env:COMPUTERNAME

#configure default Repo
$repo = Get-VBRBackupRepository -Name 'Default Backup Repository'
Set-VBRBackupRepository -Repository $repo

if ($Env:Use_Cloud_Connect -ieq "True") {

    Write-Output "$(Get-TS): Install Autorun Cloud connect"
    Copy-Item -Path C:\vbr_temp\dev.Azure.CloudConnect.Autorun -Destination 'C:\Program Files\dev\Backup and Replication\Azure Cloud Connect Service' -Recurse -Force

    #Install license
    Install-VBRLicense -Path C:\vbr_temp\v10_license_eval_backup_cc-yes_instances-100.lic

    #configure cloud gateway
    Import-Certificate -FilePath "C:\vbr_temp\dev_cloud_connect.cer" -CertStoreLocation Cert:\LocalMachine\My
    Import-Certificate -FilePath "C:\vbr_temp\dev_cloud_connect.cer" -CertStoreLocation Cert:\LocalMachine\Root

    Add-VBRCloudGateway -Description "Cloud Gateway" -Server $VBRServer -IpAddress "public.dns.name" -NetworkMode NAT

    #add tenant
    Add-VBRCloudTenant -Name "Tenant1" -Description "Change password and enable" -Password "Pass123"
    $tenant = Get-VBRCloudTenant -Name "Tenant1"
    Disable-VBRCloudTenant -CloudTenant $tenant

    #configure Autorun services
    Write-Output "$(Get-TS): Create VBRAzure service"
    sc.exe create devAzureCloudSvc binpath="C:\Program Files\dev\Backup and Replication\Azure Cloud Connect Service\dev.Azure.CloudConnect.Service" type=own start=delayed-auto depend='Winmgmt/MSSQL$devSQL2016' displayname="dev Azure Cloud Service"

    Write-Output "$(Get-TS): Add to autorun VBRAzure service"
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name "dev.Azure.CloudConnect.Autorun.exe" -Value '"C:\Program Files\dev\Backup and Replication\Azure Cloud Connect Service\dev.Azure.CloudConnect.Autorun.exe"'

    # Remove license
    Uninstall-VBRLicense -Confirm:$False

    Write-Output "$(Get-TS): Change hostname to localhost dev Gate Service ..."
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\dev\dev Gate Service' -Name CloudSvcHost -Value 'localhost'

}
else {
    Write-Output "$(Get-TS): Install Autorun VBR"
    Copy-Item -Path C:\vbr_temp\dev.Azure.VBR.Autorun -Destination 'C:\Program Files\dev\Backup and Replication\dev Azure VBR Autorun' -Recurse -Force

    Write-Output "$(Get-TS): Add to autorun VBRAzure service"
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name "dev.Azure.VBR.Autorun.exe" -Value '"C:\Program Files\dev\Backup and Replication\dev Azure VBR Autorun\dev.Azure.VBR.Autorun.exe"'
}

# Set VBR service dependency
Write-Output "$(Get-TS): Add VBR service dependency ..."
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\devBackupSvc' -Name DependOnService -Value @('Winmgmt', 'RpcSs', 'MSSQL$devSQL2016')

Write-Output "$(Get-TS): Change hostname to localhost dev Backup and Replication ..."
Set-ItemProperty -Path 'HKLM:\SOFTWARE\dev\dev Backup and Replication' -Name SqlServerName -Value 'localhost'

Write-Output "$(Get-TS): Change hostname to localhost dev Backup and Replication WOW6432 ..."
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\dev\dev Backup and Replication' -Name SqlServerName -Value 'localhost'

# Clean self signed certs
Write-Output "$(Get-TS): Clearing self signed certs."
@('Cert:\LocalMachine\Remote Desktop', 'Cert:\LocalMachine\My') | ForEach-Object {
    if (Test-Path $_) {
        Get-ChildItem $_ | Where-Object { $_.Subject -eq $_.Issuer } | Remove-Item
    }
}

# Clean root self signed cert
Write-Output "$(Get-TS): Clearing root self signed certs."
$rootCert = "CN=$env:COMPUTERNAME"
@('Cert:\LocalMachine\Root') | ForEach-Object {
    if (Test-Path $_) {
        Get-ChildItem $_ | Where-Object { $rootCert -eq $_.Issuer } | Remove-Item
    }
}

# Clean self signed certs
Write-Output "$(Get-TS): Clearing self signed cert VBR."
@('Cert:\LocalMachine\Root', 'Cert:\LocalMachine\My') | ForEach-Object {
    if (Test-Path $_) {
        Get-ChildItem $_ | Where-Object { 'CN=dev Backup Server Certificate' -eq $_.Issuer } | Remove-Item
    }
}

Disconnect-VBRServer

#Stop dev services
Write-Output "$(Get-TS): Stopping dev services"
$devServices = Get-Service -Name dev*
$devServices | ? { $_.status -eq 'running' } | stop-service

# Remove temp files VBR installation
Write-Output "$(Get-TS): Remove temp files VBR installation."
Remove-Item -LiteralPath "C:\logdir" -Force -Recurse
Remove-Item -LiteralPath "C:\vbr_temp" -Force -Recurse

# Clean VBR session
#"C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\sqlcmd.exe -S localhost\devsql2016 -d devBackup -Q 'SET QUOTED_IDENTIFIER ON; DELETE FROM [dbo].[Backup.Model.JobSessions]'"
Write-Output "$(Get-TS): Clean VBR SQL sessions"
Invoke-Sqlcmd -Query "SET QUOTED_IDENTIFIER ON; DELETE FROM [dbo].[Backup.Model.JobSessions]" -Database "devBackup" -ServerInstance "localhost\devsql2016"


Write-Output "$(Get-TS): Clean VBR SQL accounts"
$SQLVMLogin = Invoke-Sqlcmd -Query "select name from sys.server_principals" -Database "master" -ServerInstance "localhost\devsql2016" | Where-Object {
    $_.name -like "$env:COMPUTERNAME\*"
}

#Invoke-Sqlcmd -Query "DROP LOGIN $($SQLVMLogin.name)" -Database "master" -ServerInstance "localhost\devsql2016"

#Write-Output "$(Get-TS): Clean VBR SQL sessions"
#Invoke-Sqlcmd -Query "SET QUOTED_IDENTIFIER ON; DELETE FROM [dbo].[Backup.Model.JobSessions]" -Database "devBackup" -ServerInstance "localhost\devsql2016"

# Clean event log
Write-Output "$(Get-TS): Clearing events in EventViewer."
Get-WinEvent -ListLog * |
Where-Object { ($_.IsEnabled -eq 'True') -and ($_.RecordCount -gt 0) } |
ForEach-Object {
    try { [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog($_.LogName) }catch {}
}
#"Get-WinEvent -ListLog * -Force | % { Wevtutil.exe cl $_.LogName }"

# Array of files and folder that need to be deleted.
Write-Output "$(Get-TS): Clearing Temp folder"
@("C:\Windows\Prefetch\*",
    "C:\Documents and Settings\*\Local Settings\temp\*\*",
    "C:\Users\*\Appdata\Local\Temp\*\*",
    "C:\Users\*\Appdata\Local\Microsoft\Internet Explorer\*",
    "C:\Users\*\Appdata\LocalLow\Temp\*\*",
    "C:\programdata\dev\Backup\*",
    "C:\Users\*\Appdata\LocalLow\Microsoft\Internet Explorer\*"
) | ForEach-Object {
    if (Test-Path $_) {
        Remove-Item $_ -Recurse -Force -ErrorAction Ignore
    }
}

