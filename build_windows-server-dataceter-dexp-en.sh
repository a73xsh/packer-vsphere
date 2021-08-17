#! /bin/bash
cd builds/windows/windows-server-2019-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Datacenter 2019 Templates En for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Datacenter Templates en for VMware vSphere  ..."
  rm -rf /mnt/templ/windows-server-2019-datacenter-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-dexp -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  mc cp /mnt/templ/windows-server-2019-datacenter-en minio/templates --recursive
  ### All done. ###
  echo "Done."

