#!/bin/bash

set -e

main() {
  echo -e "Building a Ubuntu Sever 20.04 LTS Template for VMware vSphere ..."
  pushd "${WORKSPACE}/packer-vsphere/builds/linux/ubuntu-server-20-04-en/"
  echo "Applying the HashiCorp Packer Build ..."
  
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
  
  pushd "${WORKSPACE}/packer-vsphere/template/linux-ubuntu-server-20-04-lts-en"
  echo "remove flag vvtdEnabled"
  sed -i -E "/flags.vvtdEnabled/d" *.ovf
  sed -i -E "/flags.vbsEnabled/d" *.ovf
  sed -i -E "/nvram/d" *.ovf
  sed -i -e '/vmw:BootOrderSection/,/vmw:BootOrderSection/d' *.ovf
  
  sed -i "/\.ovf/s/= .*/= `sha256sum *.ovf |cut -d " " -f 1`/;/nvram/d" *.mf
  #pushd "${WORKSPACE}/packer-vsphere/template/"
  #ovftool --noSSLVerify "vi://administrator@vsphere.local:EHaOzo1%21@nest-vc-65.qahv1.dev.local/Datacenter/vm/Templates/linux-ubuntu-server-20-04-lts-en" .
  mc cp "${WORKSPACE}/packer-vsphere/template/linux-ubuntu-server-20-04-lts-en" minio-pdc/templates --recursive
  #rm -rf "${WORKSPACE}/packer-vsphere/template/linux-ubuntu-server-20-04-lts-en"
  echo "Done."
}

main