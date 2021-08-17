# Packer variables for Ubuntu Server 20.04 LTS.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings

http_directory = "../../../boot_config/linux/ubuntu-server/rancher"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "ubuntu"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "20-04-lts" 
vm_guest_os_type            = "ubuntu64Guest" 
vm_version                  = 13
vm_firmware                 = "bios"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "2s"
boot_command = [
  "<esc><wait><esc><wait><f6><wait><esc><wait>",
  "<bs><bs><bs><bs><bs>",
  "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
  "--- <enter>"
]

# ISO Objects
os_iso_url = [
    "ubuntu-20.04.2-live-server-amd64.iso", 
    "https://releases.ubuntu.com/20.04/ubuntu-20.04.2-live-server-amd64.iso"
]
iso_file     = "ubuntu-20.04.2-live-server-amd64.iso"
iso_checksum = "d1f2bf834bbe9bb43faf16f9be992a6f3935e65be0edece1dee2aa6eb1767423"

# Scripts

shell_scripts = [ 
  "../../../scripts/linux/ubuntu-rancher.sh"
]