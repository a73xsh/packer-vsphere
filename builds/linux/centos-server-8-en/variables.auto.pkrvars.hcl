##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

http_directory = "../../../boot_config/linux/centos-server/en"
http_file      = "ks-v8.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "centos"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "8" 
vm_guest_os_type            = "centos7_64Guest" 
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

# ISO Objects

os_iso_url = [
    "linux-centos-server-8.iso", 
    "http://pdcqas3m01.qacfg.dev.local:9000/isos/linux-centos-server-8.iso"
]
iso_file     = "linux-centos-server-8.iso"
iso_checksum = "BF0FD4464281CA0E21D4FAAA6CDD50FBA92B9C41D00524BCE286881D54C49ACD"

# Scripts

shell_scripts = [
    "../../../scripts/linux/centos-vmware.sh",
    "../../../scripts/linux/centos-yum-update.sh",
    "../../../scripts/linux/centos-cleanup.sh",
    "../../../scripts/linux/centos-clean-ssh-hostkeys.sh"
]