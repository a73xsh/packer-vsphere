#! /bin/bash
cd builds/windows/windows-server-2019-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Standard 2019 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Standard Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer validate \
      --only vsphere-iso.windows-server-standard-dexp -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."

