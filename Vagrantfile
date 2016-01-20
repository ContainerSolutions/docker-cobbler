# -*- mode: ruby -*-
# vi: set ft=ruby :
memory = ENV["VAGRANT_RAM"] || "5120"

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  # Map port where nginx/cobbler web interface will be running in the guest (80)
  # to the port where it can be accessed in the host (8080).
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8081

  # Create a private virtual network on which the DHCP server will be listening
  # for incoming broadcasts.
  # Important note: if you change the IP for the private network, make sure that
  # you also update it in the etc/cobbler/settings file, as a erroneous IP in that
  # file will keep the DHCP daemon from coming up.
  config.vm.network "private_network", ip: "192.168.56.33"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = memory
  end

  config.vm.provision "file",
    source:      "./etc/cobbler/dhcp.template",
    destination: "/tmp/cobbler-dhcp.template"

  config.vm.provision "file",
    source:      "./etc/cobbler/settings",
    destination: "/tmp/cobbler-settings"

  config.vm.provision "file",
    source:      "./etc/selinux/config",
    destination: "/tmp/selinux-config"

  config.vm.provision "file",
    source:      "./etc/xinetd.d/tftp",
    destination: "/tmp/xinetd.d-tftp"

  config.vm.provision "shell", path: "00-bootstrap.sh"
  config.vm.provision "shell", path: "01-security.sh"
  config.vm.provision "shell", path: "02-pkgconfig.sh"
  config.vm.provision "shell", path: "03-setup.sh"
end
