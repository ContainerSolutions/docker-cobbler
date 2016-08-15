# Docker-Cobbler
Cobbler in a Docker container

This repository aims to provide a fully functional Cobbler server in a Docker container.
Please refer to [this blog](http://container-solutions.com/cobbler-in-a-docker-container/) for an explanation.

## Getting Started

Adjust the configuration files in etc/cobbler.

* In the *settings* file, adjust at least these settings:
  * default_password_crypted
  * manage_dhcp
  * manage_dns
  * manage_forward_zones
  * manage_reverse_zones
  * next_server
  * pxe_just_once
  * server
  

Use the accompanied Makefile to set it up. Issue make <target\> to make the following:

*build*	  Build the image

*run*    Run the Docker container

* clean:  Remove the docker container
* mount:  Mount an iso (currently named centos.iso) located in the dist/-directory on the path dist/centos. For use with the import target.
* tty:    Attach to a console inside the container
* stop:   Stop the container
* start:  Start the container
* import: Import a distribution into Cobbler. Currently only Centos7. Requires a centos iso to be mounted on dist/centos, see mount target.
* all:    Build image, mount iso, run the container and import the distribution
* vbox:   Create a VirtualBox VNIC for listening on and issuing DHCP addresses. This is for testing Cobbler functionality in combination with Virtualbox VMs. Requires a working VirtualBox installation.


