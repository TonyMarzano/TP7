Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.network "private_network", type: "dhcp"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    config.vm.provision "shell", path: "provision.sh"
  end
  