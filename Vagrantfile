# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  
  config.vm.define :nginxMaster do |nginxMaster_config|
    nginxMaster_config.vm.hostname = 'nginxmaster'
    nginxMaster_config.vm.network :private_network, ip: '192.168.50.10'
    nginxMaster_config.vm.provision :shell, path: "setupNeginxMaster.sh"
  end
  config.vm.define :nginxSlave do |nginxSlave_config|
    nginxSlave_config.vm.hostname = 'nginxslave'
    nginxSlave_config.vm.network :private_network, ip: '192.168.50.11'
    nginxSlave_config.vm.provision :shell, path: "setupNeginxSlave.sh"
  end  
end
