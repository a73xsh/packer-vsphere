#!/bin/bash

set -e

main() {
  echo -e "Build Microsoft Windows Server Datacenter 2019 Core Templates En for VMware vSphere."
  pushd "${WORKSPACE}/packer-vsphere/builds/windows/windows-server-2019-en/"
  echo "Applying the HashiCorp Packer Build ..."
  
  packer init "${WORKSPACE}/packer-vsphere/builds/windows/config.pkr.hcl"
  
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-core -var-file="../../../vsphere.pkrvars.hcl" .
  
  pushd "${WORKSPACE}/packer-vsphere/template/windows-server-2019-datacenter-core-en"
  ls
  echo "remove flag vvtdEnabled"
  sed -i -E "/flags.vvtdEnabled/d" *.ovf
  sed -i -E "/flags.vbsEnabled/d" *.ovf
  sed -i -E "/nvram/d" *.ovf
  sed -i -e '/vmw:BootOrderSection/,/vmw:BootOrderSection/d' *.ovf
  
  sed -i "/\.ovf/s/= .*/= `sha256sum *.ovf |cut -d " " -f 1`/;/nvram/d" *.mf

  mc cp "${WORKSPACE}/packer-vsphere/template/windows-server-2019-datacenter-core-en" minio-pdc/templates --recursive
  echo "Done."
}

main