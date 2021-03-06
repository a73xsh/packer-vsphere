#!/bin/bash

set -e
set -x

# Prevents popup questions
export DEBIAN_FRONTEND="noninteractive"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# Need gnupg for fish
sudo apt-get install -y gnupg
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y git
sudo apt-get install -y net-tools
sudo apt-get install -y unzip
sudo apt-get install -y openssh-server