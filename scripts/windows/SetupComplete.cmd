powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
PowerShell "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force"
PowerShell -File "C:\Windows\Setup\Scripts\ConfigureRemotingForAnsible.ps1" "-EnableCredSSP"
PowerShell -File "C:\Windows\Setup\Scripts\ServerFirewall.ps1"
del /Q /F c:\unattend.xml
del /Q /F c:\windows\panther\unattend.xml
rem Shutdown -r -t 0