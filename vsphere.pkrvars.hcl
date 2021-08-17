##################################################################################
# VARIABLES Packer input variables for all builds.
##################################################################################

# Credentials

vcenter_username = "packer@vsphere.local"
vcenter_password = "Pa$$w0rd"
build_username   = "ansible"
build_password   = "Pa$$w0rd"

# vSphere Objects

vcenter_insecure_connection     = true
vcenter_server                  = "vcenter.dev.lab"
vcenter_datacenter              = "Datacenter"
vcenter_cluster                 = "Cluster"
vcenter_datastore               = "Datastore"
vcenter_network                 = "VM-Net"
vcenter_folder                  = "Templates"
vcenter_content_library         = "Test-Packer"

# ISO Objects
