#!/usr/bin/env bash

# Disable SELinux
setenforce 0
setsebool -P httpd_can_network_connect true
mkdir -p /selinux
echo 0 > /selinux/enforce
