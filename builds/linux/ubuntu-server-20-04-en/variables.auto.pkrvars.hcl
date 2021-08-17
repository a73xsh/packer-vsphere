# Packer variables for Ubuntu Server 20.04 LTS.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings

http_directory = "../../../boot_config/linux/ubuntu-server/en"

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
vm_boot_wait                = "5s"
boot_command = [
  "<esc><wait><esc><wait><f6><wait><esc><wait>",
  "<bs><bs><bs><bs><bs>",
  "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
  "--- <enter>"
]

# ISO Objects
os_iso_url = [
    "linux-ubuntu-server-20-04.iso", 
    "http://pdcqas3m01.qacfg.dev.local:9000/isos/linux-ubuntu-server-20-04.iso"
]
iso_file     = "linux-ubuntu-server-20-04.iso"
iso_checksum = "D1F2BF834BBE9BB43FAF16F9BE992A6F3935E65BE0EDECE1DEE2AA6EB1767423"

# Scripts

shell_scripts = ["../../../scripts/linux/ubuntu-server-cleanup.sh"]
#shell_scripts = [ 
#  "../../../scripts/linux/ubuntu-apt.sh",
#  "../../../scripts/linux/ubuntu-cleanup.sh",
#  "../../../scripts/linux/ubuntu-prep.sh",
#  "../../../scripts/linux/ubuntu-clean-ssh-hostkeys.sh",
#]