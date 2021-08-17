#!/bin/bash

BASEDIR=$(pwd)

menu_option_1() {
  cd builds/windows/windows-server-2019-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2019 Standart Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Standard Templates for VMware vSphere  ..."
   # rm -rf /mnt/templ/windows-server-2019-standard-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-standard-dexp \
      -var-file="../../../vsphere.pkrvars.hcl" .

  echo "Copy template to bucket"
  # mc cp /mnt/templ/windows-server-2019-standard-en minio/templates --recursive  
  ### All done. ###
  echo "Done."
}

menu_option_2() {
  cd builds/windows/windows-server-2019-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Standard 2019 Core Templates En for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Core Standard Templates en for VMware vSphere  ..."
   # rm -rf /mnt/templ/windows-server-2019-standard-core-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-standard-core -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/windows-server-2019-standard-core-en minio/templates --recursive
  ### All done. ###
  echo "Done."
}

menu_option_3() {
  cd builds/windows/windows-server-2019-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Datacenter 2019 Templates En for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Datacenter Templates en for VMware vSphere  ..."
   # rm -rf /mnt/templ/windows-server-2019-datacenter-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-dexp -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/windows-server-2019-datacenter-en minio/templates --recursive
  ### All done. ###
  echo "Done."
}

menu_option_4() {
  cd builds/windows/windows-server-2019-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Datacenter 2019 Core Templates En for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Datacenter Core Templates en for VMware vSphere  ..."
   # rm -rf /mnt/templ/windows-server-2019-datacenter-core-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-core -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/windows-server-2019-datacenter-core-en minio/templates --recursive
  ### All done. ###
  echo "Done."
}

menu_option_5() {
  cd builds/windows/windows-server-2016-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2016 Standart Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2016 Standard Templates for VMware vSphere  ..."
   # rm -rf /mnt/templ/windows-server-2016-standard-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-standard-dexp \
      -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/windows-server-2016-standard-en minio/templates --recursive

  ### All done. ###
  echo "Done."
}

menu_option_6() {
  cd builds/windows/windows-server-2016-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Standard 2016 Core Templates En for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2016 Core Standard Templates en for VMware vSphere  ..."
   # rm -rf /mnt/templ/windows-server-2016-standard-core-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-standard-core -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/windows-server-2016-standard-core-en minio/templates --recursive
  ### All done. ###
  echo "Done."
}

menu_option_7() {
  cd builds/windows/windows-server-2016-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Datacenter 2016 Templates En for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Datacenter Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2016 Datacenter Templates en for VMware vSphere  ..."
   # rm -rf /mnt/templ/windows-server-2016-datacenter-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-dexp -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/windows-server-2016-datacenter-en minio/templates --recursive
  ### All done. ###
  echo "Done."
}

menu_option_8() {
  cd builds/windows/windows-server-2016-en/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Datacenter 2016 Core Templates En for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2016 Datacenter Core Templates en for VMware vSphere  ..."
   # rm -rf /mnt/templ/windows-server-2016-datacenter-core-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-core -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/windows-server-2016-datacenter-core-en minio/templates --recursive
  ### All done. ###
  echo "Done."
}

menu_option_9() {
  cd builds/linux/ubuntu-server-20-04-en/
  echo -e "\nCONFIRM: Build a Ubuntu Server 20.04 LTS Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a Ubuntu Sever 20.04 LTS Template for VMware vSphere ###
  echo "Building a Ubuntu Sever 20.04 LTS Template for VMware vSphere ..."
   # rm -rf /mnt/templ/linux-ubuntu-server-20-04-lts-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/linux-ubuntu-server-20-04-lts-en minio/templates --recursive
  ### All done. ###
  echo "Done."
}

menu_option_10() {
  cd builds/linux/centos-server-8-en/
  echo -e "\nCONFIRM: Build a CentOS Server 8 Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build n CentOS 8 Template for VMware vSphere ###
  echo "Building a CentOS Server 8 Template for VMware vSphere  ..."
  rm -f /mnt/templ/linux-centos-server-8-en

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/linux-centos-server-8-en minio/templates --recursive
  ### All done. ###
  echo "Done."
  
}

menu_option_11() {
  cd builds/linux/photon-server-4/
  echo -e "\nCONFIRM: Build a VMware Photon OS 4 Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a VMware Photon OS 4 Template for VMware vSphere ###
  echo "Building a CentOS Server 8 Template for VMware vSphere  ..."
  rm -f /mnt/templ/linux-photon-server-4

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
  # mc cp /mnt/templ/linux-photon-server-4 minio/templates --recursive
  ### All done. ###
  echo "Done."
  
}

menu_option_12() {
  cd builds/linux/ubuntu-server-rancher/
  echo -e "\nCONFIRM: Build a Ununtu Rancher Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a VMware Photon OS 4 Template for VMware vSphere ###
  echo "Building a Ununtu Rancher Template for VMware vSphere  ..."
  rm -f /mnt/templ/ubuntu2004-nocloud

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
  
  echo "Copy template to bucket"
   mc cp /mnt/templ/ubuntu2004-nocloud minio/templates --recursive
  ### All done. ###
  echo "Done."
  
}

press_enter() {
  cd "$BASEDIR"
  echo -n "Press Enter to continue."
  read
  clear
}

incorrect_selection() {
  echo "Do or do not. There is no try."
}

until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo "    ___      _      _____                          _ _         ____        _ _     _  "
  echo "   / _ \    / \    |_   _|__ _ __ ___  _ __   __ _| | |_ ___  | __ ) _   _(_) | __| | "
  echo "  | | | |  / _ \     | |/ _ \ '_ ' _ \| '_ \ / _' | | __/ _ \ |  _ \| | | | | |/ _' | "
  echo "  | |_| | / ___ \    | |  __/ | | | | | |_) | (_| | | ||  __/ | |_) | |_| | | | (_| | "
  echo "   \__\_\/_/   \_\   |_|\___|_| |_| |_| .__/ \__,_|_|\__\___| |____/ \__,_|_|_|\__,_| "
  echo "                                    |_|                                               "
  echo ""
  echo -n "  Select a HashiCorp Packer build for VMware vSphere:"
  echo ""
  echo ""
  echo "      Microsoft Windows:"
  echo ""
  echo "    	 1  -  Windows Server 2019 EN - Standard GUI"
  echo "    	 2  -  Windows Server 2019 EN - Standard Core"
  echo "    	 3  -  Windows Server 2019 EN - Datacenter GUI"
  echo "    	 4  -  Windows Server 2019 EN - Datacenter Core"
  echo "    	 5  -  Windows Server 2016 EN - Standard GUI"
  echo "    	 6  -  Windows Server 2016 EN - Standard Core"
  echo "    	 7  -  Windows Server 2016 EN - Datacenter GUI"   
  echo "    	 8  -  Windows Server 2016 EN - Datacenter Core" 
  echo ""
  echo ""
  echo "      Linux Distribution:"
  echo ""
  echo "    	 9  -  Ubuntu Server 20.04 EN LTS"
  echo "    	 10 -  CentOS Server 8"
  echo "    	 11 -  VMware Photon OS 4"
  echo "    	 12 -  Ubuntu Server Rancher" 
  echo " "
  echo " "
  echo ""
  echo ""
  echo "      Other:"
  echo ""
  echo "        I   -  Information"
  echo "        Q   -  Quit"
  echo ""
  read selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_1 ; press_enter ;;
    2 ) clear ; menu_option_2 ; press_enter ;;
    3 ) clear ; menu_option_3 ; press_enter ;;
    4 ) clear ; menu_option_4 ; press_enter ;;
    5 ) clear ; menu_option_5 ; press_enter ;;
    6 ) clear ; menu_option_6 ; press_enter ;;
    7 ) clear ; menu_option_7 ; press_enter ;;
    8 ) clear ; menu_option_8 ; press_enter ;;
    9 ) clear ; menu_option_9 ; press_enter ;;
    10 ) clear ; menu_option_10 ; press_enter ;;
    11 ) clear ; menu_option_11 ; press_enter ;;
    12 ) clear ; menu_option_12 ; press_enter ;;
    13 ) clear ; menu_option_13 ; press_enter ;;
    14 ) clear ; menu_option_14 ; press_enter ;;
    I ) clear ; info ; press_enter ;;
    Q ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done