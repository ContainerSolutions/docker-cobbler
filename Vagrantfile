# -*- mode: ruby -*-
# vi: set ft=ruby :

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

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./", "/usr/src/cobbler"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "5120"
    vb.cpus = "8"
  end

  config.vm.provision "shell", inline: <<-EOF
    yum -y update
    yum -y install epel-release
    yum -y install cobbler cobbler-web dhcp syslinux pykickstart
    systemctl enable cobblerd
    systemctl enable httpd
    systemctl enable dhcpd
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
