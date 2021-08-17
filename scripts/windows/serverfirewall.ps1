#  Enable ping requests in and out
Set-NetFirewallRule -Name FPS-ICMP4-ERQ-In -Enabled True -Profile Any -RemoteAddress Any
Set-NetFirewallRule -Name FPS-ICMP6-ERQ-In -Enabled True -Profile Any -RemoteAddress Any
Set-NetFirewallRule -Name FPS-ICMP4-ERQ-Out -Enabled True -Profile Any -RemoteAddress Any
Set-NetFirewallRule -Name FPS-ICMP6-ERQ-Out -Enabled True -Profile Any -RemoteAddress Any

#  Enable remote volume management
Set-NetFirewallRule -Name RVM-VDS-In-TCP    -Enabled True -Profile Any
Set-NetFirewallRule -Name RVM-VDSLDR-In-TCP -Enabled True -Profile Any
Set-NetFirewallRule -Name RVM-RPCSS-In-TCP  -Enabled True -Profile Any

#  Enable remote service management
Set-NetFirewallRule -Name RemoteSvcAdmin-In-TCP       -Enabled True -Profile Any
Set-NetFirewallRule -Name RemoteSvcAdmin-NP-In-TCP    -Enabled True -Profile Any
Set-NetFirewallRule -Name RemoteSvcAdmin-RPCSS-In-TCP -Enabled True -Profile Any

#  Enable Remote Event Log Management
Set-NetFirewallRule -Name RemoteEventLogSvc-In-TCP       -Enabled True -Profile Any
Set-NetFirewallRule -Name RemoteEventLogSvc-NP-In-TCP    -Enabled True -Profile Any
Set-NetFirewallRule -Name RemoteEventLogSvc-RPCSS-In-TCP -Enabled True -Profile Any

#  Enable Remote Scheduled Tasks Management
Set-NetFirewallRule -Name RemoteTask-In-TCP       -Enabled True -Profile Any
Set-NetFirewallRule -Name RemoteTask-RPCSS-In-TCP -Enabled True -Profile Any

#  Enable Windows Firewall Remote Management
Set-NetFirewallRule -Name RemoteFwAdmin-In-TCP       -Enabled True -Profile Any
Set-NetFirewallRule -Name RemoteFwAdmin-RPCSS-In-TCP -Enabled True -Profile Any

#  Allow PowerShell remoting from any subnet
Set-NetFirewallRule -Name WinRM-HTTP-In-TCP-Public -RemoteAddress Any -Profile Public

#  Enable WMI management requests in
Set-NetFirewallRule -Name WMI-WINMGMT-In-TCP -Enabled True -Profile Any

#  Enable Remote Shutdown
Set-NetFirewallRule -Name Wininit-Shutdown-In-Rule-TCP-RPC -Enabled True -Profile Any

#  Enable Network Discovery on the Domain Network
Set-NetFirewallRule -Name NETDIS-FDPHOST-In-UDP  -Enabled True -Profile Domain
Set-NetFirewallRule -Name NETDIS-FDPHOST-Out-UDP -Enabled True -Profile Domain

#  Set some services to automatically start and start them.
Set-Service   -Name PlugPlay -StartupType Automatic
Start-Service PlugPlay
Set-Service   -Name RemoteRegistry -StartupType Automatic
Start-Service RemoteRegistry
Set-Service   -Name vds -StartupType Automatic
Start-Service vds

# Enable PSremoting
Enable-PSRemoting -Confirm:$False

#  Enable Remote Desktop
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Value 0

#  Enable Remote Desktop rules for all profiles
Set-NetfirewallRule -Name RemoteDesktop-UserMode-In-TCP -Enabled True -Profile Any
Set-NetfirewallRule -Name RemoteDesktop-UserMode-In-UDP -Enabled True -Profile Any

#  Set Windows SmartScreen to require administrator approval
#New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -Name EnableSmartScreen -Value 2 -PropertyType DWord -Force | Out-Null

#  Set local administrator password to never expire
Set-LocalUser -Name Administrator -PasswordNeverExpires:$true
Set-LocalUser -Name ansible -PasswordNeverExpires:$true