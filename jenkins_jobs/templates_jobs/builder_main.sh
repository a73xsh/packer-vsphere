#!/bin/bash

set -e

main() {
  pwd
  echo -e "Build Template for VMware vSphere."
  /bin/bash "${WORKSPACE}/packer-vsphere/jenkins_jobs/builds/${TEMPLATE}.sh"
  sleep 10
}

main