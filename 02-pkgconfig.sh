#!/usr/bin/env bash

# Put config files in place
mv /tmp/cobbler-dhcp.template /etc/cobbler/dhcp.template
mv /tmp/cobbler-settings /etc/cobbler/settings
mv /tmp/selinux-config /etc/selinux/config
mv /tmp/xinetd.d-tftp /etc/xinetd.d/tftp
touch /etc/xinetd.d/rsync

# Enable httpd on system start
systemctl enable httpd

# Enable cobbler on system start
systemctl enable cobblerd
