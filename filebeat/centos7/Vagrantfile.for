vm_cpus ||= 4
vm_memory ||= 4096
vm_gui ||= false
node_ip="192.168.100.100"

Vagrant.configure("2") do |config|

  config.vagrant.plugins = "vagrant-docker-compose"

  config.vm.box = "for-filebeat/centos7"
  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |v|
    v.cpus = vm_cpus
    v.memory = vm_memory
    v.gui = vm_gui
    v.linked_clone = true
  end



  config.vm.hostname = "hello"
  config.vm.network :private_network, ip: node_ip, virtualbox__intnet: true
  config.vm.network "forwarded_port", guest: 5601, host: 5601

  config.vm.synced_folder "../.", "/home/vagrant/filebeat"

  config.vm.provision :docker
  config.vm.provision :docker_compose, yml:"/home/vagrant/filebeat/vm/containers/kafka/docker-compose-single-broker.yml", run:"always"
  config.vm.provision :docker_compose, yml:"/home/vagrant/filebeat/vm/containers/es-kibana/docker-compose.yml", run:"always"


end