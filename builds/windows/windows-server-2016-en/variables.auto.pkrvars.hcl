##################################################################################
# Packer variables for Windows Server 2019 Standard and Datacenter- Desktop Experience and Core
##################################################################################

# Virtual Machine Settings

vm_guest_os_family          = "windows"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "2016"
vm_guest_os_edition_std     = "standard"
vm_guest_os_edition_dc      = "datacenter"
vm_guest_os_type            = "windows9Server64Guest"
vm_version                  = 13
vm_firmware                 = "bios"
vm_boot_command             = ["<spacebar>"]
vm_boot_wait                = "2s"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 8192
vm_disk_size                = 102400
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_floppy_files_server_std_dexp = [
  "../../../boot_config/windows/windows-server-2016/standard/en/bios/autounattend.xml",
  "../../../scripts/windows/",
  "../../../drivers/windows",
  "../../../certificates/"
  ]
vm_floppy_files_server_std_core = [
  "../../../boot_config/windows/windows-server-2016/standard-core/en/bios/autounattend.xml",
  "../../../scripts/windows/",
  "../../../drivers/windows",
  "../../../certificates/"
  ]
vm_floppy_files_server_dc_dexp = [
  "../../../boot_config/windows/windows-server-2016/datacenter/en/bios/autounattend.xml",
  "../../../scripts/windows/",
  "../../../drivers/windows",
  "../../../certificates/"
  ]
vm_floppy_files_server_dc_core = [
  "../../../boot_config/windows/windows-server-2016/datacenter-core/en/bios/autounattend.xml",
  "../../../scripts/windows/",
  "../../../drivers/windows",
  "../../../certificates/"
  ]
vm_shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""

# ISO Objects

os_iso_url = [
    "windows-server-2016-en.iso", 
    "http://172.21.220.72:9000/isos/windows-server-2016-en.iso"
]
iso_file      = "windows-server-2016-en.iso"
iso_checksum  = "sha256:47919CE8B4993F531CA1FA3F85941F4A72B47EBAA4D3A321FECF83CA9D17E6B8"

# PowerShell Provisioner Objects

powershell_scripts = [
  "../../../scripts/windows/windows-server-cleanup.ps1"
  ]
install_bginfo =[
  "../../../scripts/windows/install-bginfo.ps1"
]

powershell_inline = [
  "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))",
  "choco feature enable -n allowGlobalConfirmation",
  "choco install googlechrome",
  "choco install firefox",
  "choco install winscp",
  "choco install hxd",
  "choco install notepadplusplus.install",
  "choco install crystaldiskmark",
  "choco install lockhunter",
  "choco install 7zip",
  "choco install procexp",
  "choco install hashcheck",
  "Get-EventLog -LogName * | ForEach { Clear-EventLog -LogName $_.Log }"
  ]