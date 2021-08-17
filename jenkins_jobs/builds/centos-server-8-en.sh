#!/bin/bash

set -e

main() {
  echo -e "Build a CentOS Server 8 Template for VMware vSphere."
  pushd "${WORKSPACE}/packer-vsphere/builds/linux/centos-server-8-en/"
  echo "Applying the HashiCorp Packer Build ..."
  
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
  
  pushd "${WORKSPACE}/packer-vsphere/template/linux-centos-server-8-en"
  echo "remove flag vvtdEnabled"
  sed -i -E "/flags.vvtdEnabled/d" *.ovf
  sed -i -E "/flags.vbsEnabled/d" *.ovf
  sed -i -E "/nvram/d" *.ovf
  sed -i -e '/vmw:BootOrderSection/,/vmw:BootOrderSection/d' *.ovf
  
  sed -i "/\.ovf/s/= .*/= `sha256sum *.ovf |cut -d " " -f 1`/;/nvram/d" *.mf

  mc cp "${WORKSPACE}/packer-vsphere/template/linux-centos-server-8-en" minio-pdc/templates --recursive
  echo "Done."
}

main