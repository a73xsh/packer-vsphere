##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings

http_directory = "../../../boot_config/linux/photon-server"
http_file      = "ks.json"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "photon"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "4"
vm_guest_os_type            = "vmwarePhoton64Guest" 
vm_version                  = 14
vm_firmware                 = "bios"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "5s"

# ISO Objects

os_iso_url = [
    "photon-minimal-4.iso", 
    "http://172.17.172.55:9000/isos/photon-minimal-4.iso"
]
iso_file     = "photon-minimal-4.iso"
iso_checksum = "881989EA6336A98D3FCD500EE273C1323B0F8B7A9D4CFC4FED1F015B1AA85F5E"

# Scripts

shell_scripts = ["../../../scripts/linux/photon-server-cleanup.sh"]