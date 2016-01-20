#!/usr/bin/env bash

# Install system dependencies:
# * Cobbler
# * Cobbler WebUI
# * DHCP daemon
# * syslinux
# * pykickstart (for Cobbler to generate dynamic kickstart files)
# * unzip
# * Terraform
yum -y update
yum -y install epel-release
yum -y install cobbler cobbler-web dhcp bind syslinux syslinux pykickstart unzip yum-utils
curl https://releases.hashicorp.com/terraform/0.6.9/terraform_0.6.9_linux_amd64.zip > /tmp/terraform.zip
sudo unzip -d /usr/local/bin /tmp/terraform.zip
rm /tmp/terraform.zip
