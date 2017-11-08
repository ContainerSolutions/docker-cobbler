# -*- mode: ruby -*-
# vi: set ft=ruby :
memory = ENV["VAGRANT_RAM"] || "5120"

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.56.1"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  config.vm.synced_folder "./", "/usr/src/cobbler"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = memory
  end

  config.vm.provision "shell", inline: <<-EOF
    yum -y update
    yum -y install epel-release
    yum -y install cobbler cobbler-web dhcp syslinux pykickstart xinetd
    systemctl enable cobblerd
    systemctl enable httpd
    systemctl enable dhcpd
    systemctl enable xinetd
    sed -i -e 's/\(^.*disable.*=\) yes/\1 no/' /etc/xinetd.d/tftp
    sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    setenforce 0
    setsebool -P httpd_can_network_connect true
    systemctl start cobblerd
    systemctl start httpd
    cobbler get-loaders
    cobbler sync
  EOF
end
