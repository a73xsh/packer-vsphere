##################################################################################
# VARIABLES
##################################################################################

# Credentials.

variable "vcenter_username" {
  type    = string
  description = "The username to login to the vCenter Server instance. (e.g. svc-packer)"
  default = ""
  sensitive = true
}

variable "vcenter_password" {
  type      = string
  description = "The password for the login to the vCenter Server instance."
  default = ""
  sensitive = true
}

variable "build_username" {
  type    = string
  description = "The username to login to the guest operating system. (e.g. ansible)"
  default = ""
  sensitive = true
}

variable "build_password" {
  type      = string
  description = "The password for the login to the guest operating system."
  default = ""
  sensitive = true
}

# vSphere Objects

variable "vcenter_insecure_connection" {
  type    = bool
  description = "Do not validate vCenter Server TLS certificate."
  default = true
}

variable "vcenter_server" {
  type    = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance. (e.g. 'svcenter.vsphere.local)"
  default = ""
}

variable "vcenter_datacenter" {
  type    = string
  description = "The name of the target vSphere datacenter. (e.g. 'Datacenter')"
  default = ""
}

variable "vcenter_cluster" {
  type    = string
  description = "The name of the target vSphere cluster. (e.g. 'Cluster')"
  default = ""
}

variable "vcenter_datastore" {
  type    = string
  description = "The name of the target vSphere datastore. (e.g. 'Cluster-vsan01')"
  default = ""
}

variable "vcenter_network" {
  type    = string
  description = "The name of the target vSphere network segment. (e.g. 'VM-Network')"
  default = ""
}

variable "vcenter_folder" {
  type    = string
  description = "The name of the target vSphere cluster. (e.g. 'Template')"
  default = ""
}

variable "vcenter_content_library" {
  type    = string
  description = "The name of the target vSphere content library, if used. (e.g. 'Cluster-lib01')"
  default = ""
}

# ISO Objects

variable "iso_datastore" {
  type    = string
  description = "The name of the source vSphere datastore for ISO images. (e.g. 'Cluster-nfs01')"
  default = ""
  }

variable "iso_path" {
  type    = string
  description = "The path on the source vSphere datastore for ISO images. (e.g. 'iso')"
  default = ""
  }

variable "iso_file" {
  type    = string
  description = "The file name of the ISO image. (e.g. 'iso-ubuntu-server-20-04-lts')"
  default = ""
}

variable "iso_checksum" {
  type    = string
  description = "The SHA-512 checkcum of the ISO image. (e.g. Result of 'shasum -a 512 iso-ubuntu-server-20-04-lts')"
  default = ""
}

variable "os_iso_url" {
  description = "The path on the source vSphere datastore for ISO images EN locale. (e.g. 'iso')"
}

# HTTP Endpoint for Kickstart

variable "http_directory" {
  type    = string
  description = "The HTTP endpoint directory path. (e.g. ../../../configs/linux/ubuntu-server/)"
  default = ""
}

variable "boot_command" {}

# Virtual Machine Settings

variable "vm_guest_os_family" {
  type    = string
  description = "The guest operatiing system family. Used for naming and VMware tools. (e.g. ''linux')"
  default = ""
}

variable "vm_guest_os_vendor" {
  type    = string
  description = "The guest operatiing system vendor. Used for naming . (e.g. 'ubuntu')"
  default = ""
}

variable "vm_guest_os_member" {
  type    = string
  description = "The guest operatiing system member. Used for naming. (e.g. 'server')"
  default = ""
}

variable "vm_guest_os_version" {
  type    = string
  description = "The guest operatiing system version. Used for naming. (e.g. '20-04-lts')"
  default = ""
}

variable "vm_guest_os_type" {
  type    = string
  description = "The guest operating system type, also know as guestid. (e.g. 'ubuntu64Guest')"
  default = ""
}

variable "vm_version" {
  type    = number
  description = "The vSphere virtual hardware version. Refer to https://kb.vmware.com/kb/1003746. (e.g. '18')"
  default = 13
}

variable "vm_firmware" {
  type    = string
  description = "The virtual machine firmware. (e.g. 'bios' or 'efi')"
  default = "bios"
}

variable "vm_cdrom_type" {
  type    = string
  description = "The virtual machine CD-ROM type. (e.g. 'sata', or 'ide')"
  default = "sata"
}

variable "vm_cpu_sockets" {
  type    = number
  description = "The number of virtual CPUs sockets. (e.g. '2')"
  default = 2
}

variable "vm_cpu_cores" {
  type    = number
  description = "The number of virtual CPUs cores per socket. (e.g. '1')"
  default = 1
}

variable "vm_mem_size" {
  type    = number
  description = "The size for the virtual memory in MB. (e.g. '2048')"
  default = 2048
}

variable "vm_disk_size" {
  type    = number
  description = "The size for the virtual disk in MB. (e.g. '40960')"
  default = 40960
}

variable "vm_disk_controller_type" {
  type    = list(string)
  description = "The virtual disk controller types in sequence. (e.g. 'pvscsi')"
  default = ["pvscsi"]
}

variable "vm_network_card" {
  type    = string
  description = "The virtual network card type. (e.g. 'vmxnet3' or 'e1000e')"
  default = "vmxnet3"
}

variable "vm_boot_wait" {
  type    = string
  description = "The time to wait before boot. "
  default = "2s"
}

variable "shell_scripts" {
  type    = list(string)
  description = "A list of script and their relative paths to transfer and execute using SSH."
  default = []
}

##################################################################################
# LOCALS
##################################################################################

locals { 
  buildtime = formatdate("YYYYMMDD hh:mm ZZZ", timestamp())
  }

##################################################################################
# SOURCE
##################################################################################

source "vsphere-iso" "linux-ubuntu-server" {
  vcenter_server       = var.vcenter_server
  username             = var.vcenter_username
  password             = var.vcenter_password
  datacenter           = var.vcenter_datacenter
  cluster              = var.vcenter_cluster
  datastore            = var.vcenter_datastore
  folder               = var.vcenter_folder
  insecure_connection  = var.vcenter_insecure_connection
  tools_upgrade_policy = true
  remove_cdrom         = true
  convert_to_template  = true
  guest_os_type        = var.vm_guest_os_type
  vm_version           = var.vm_version
  notes                = "Built by QA Config Team Packer \n __date: ${local.buildtime}."
  vm_name              = "${var.vm_guest_os_family}-${var.vm_guest_os_vendor}-${var.vm_guest_os_member}-${var.vm_guest_os_version}-en"
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = false
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = false
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = var.vcenter_network
    network_card = var.vm_network_card
  }
  iso_urls                  = var.os_iso_url
  iso_checksum              = var.iso_checksum
  http_directory            = var.http_directory
  boot_order                = "disk,cdrom"
  boot_wait                 = var.vm_boot_wait
  boot_command              = var.boot_command
  ip_wait_timeout           = "20m"
  ssh_password              = var.build_password
  ssh_username              = var.build_username
  ssh_port                  = 22
  ssh_timeout               = "20m"
  ssh_handshake_attempts    = "100"
  shutdown_command          = "echo '${var.build_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout          = "15m"
  export {
    force = true
    output_directory = "../../../template/${var.vm_guest_os_family}-${var.vm_guest_os_vendor}-${var.vm_guest_os_member}-${var.vm_guest_os_version}-en"
  }
}

##################################################################################
# BUILD
##################################################################################

build {
  sources = ["source.vsphere-iso.linux-ubuntu-server"]

  provisioner "file" {
    destination = "/tmp/root-ca.crt"
    source = "../../../certificates/root-ca.crt"
  }
  
  // Uses the Shell Provisioner to execute a series of inline commands defined in the variables
  provisioner "shell" {
    execute_command = "echo '${var.build_password}' | {{.Vars}} sudo -E -S sh -eux '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.build_username}",
    ]
    scripts = var.shell_scripts
    expect_disconnect = true
  }
}
