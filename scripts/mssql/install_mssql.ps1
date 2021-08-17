# This script installs SQL Server Express 2016.
function Install-SQLServerExpress2016 {
    Write-Host "Downloading SQL Server Express 2016..."
    $Path = $env:TEMP
    $Installer = "SQLEXPR_x64_ENU.exe"
    $URL = "http://172.21.220.72:9000/utils/2016SP2/SQLEXPR_x64_ENU.exe"
    Invoke-WebRequest $URL -OutFile $Path\$Installer

    Write-Host "Installing SQL Server Express..."
    Write-Output "Unpacking SQL Server 2016 Express"
    $Arguments = "/x:`"$Path\SqlExpress`" /u "
    Start-Process "$Path\$Installer" -ArgumentList $Arguments -Wait -NoNewWindow

    Write-Output "Installing SQL Server 2016 Express: this may take a while"
    $Arguments = "/HIDECONSOLE /Q /IACCEPTSQLSERVERLICENSETERMS /ACTION=install /FEATURES=SQLEngine,SNAC_SDK /INSTANCENAME=devSQL2016 /SQLSVCACCOUNT=`"NT AUTHORITY\SYSTEM`" /SQLSYSADMINACCOUNTS=`"Builtin\Administrators`" /TCPENABLED=1 /NPENABLED=1 /UpdateEnabled=0"
    Start-Process "$Path\SqlExpress\SETUP.exe" -ArgumentList $Arguments -Wait -NoNewWindow

    Remove-Item $Path\$Installer
}

Install-SQLServerExpress2016