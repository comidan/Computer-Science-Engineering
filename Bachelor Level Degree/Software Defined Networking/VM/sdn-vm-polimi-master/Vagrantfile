## Vagrantfile for SDN class Politecnico di Milano

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/xenial64"
  #config.vm.box = "ubuntu/bionic64"
 
 ## Guest Config
 config.vm.hostname = "polimi-sdn"

 # onos gui
 config.vm.network "forwarded_port", guest:8181, host:8181

 # ryu gui
 config.vm.network "forwarded_port", guest:8080, host:8080 
 
 #default ssh to 2222
 #config.ssh.guest_port = 22
 
 ## Provisioning 
   
 config.vm.provision "shell", path: "setup/basic-setup.sh"
 config.vm.provision "shell", privileged: false, path: "setup/mininet-setup.sh"
 config.vm.provision "shell", privileged: false, path: "setup/ryu-setup.sh"
 # config.vm.provision "shell", privileged: false, path: "setup/onos-setup.sh", env: {"ONOS_VERSION" => "1.12.0"}
 # config.vm.provision "shell", privileged: false, path: "setup/onosdocker-setup.sh"

 # x11 not necessary
 # change to true if x11 is available
 config.ssh.forward_x11 = false

end
