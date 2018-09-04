# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "centos7", primary: true do |centos7|
    centos7.vm.box = "actinium/centos7"
    centos7.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    centos7.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    centos7.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
    end
  end
  config.vm.define "ubuntu14", autostart: false do |ubuntu14|
    ubuntu14.vm.box = "actinium/ubuntu14"
    ubuntu14.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    ubuntu14.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    ubuntu14.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
    end
  end
  config.vm.define "fedoraserver28", autostart: false do |fedoraserver28|
    fedoraserver28.vm.box = "actinium/fedoraserver28"
    fedoraserver28.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    fedoraserver28.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    fedoraserver28.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
    end
  end
  config.vm.define "fedoraatomic28", autostart: false do |fedoraatomic28|
    fedoraatomic28.vm.box = "actinium/fedoraatomic28"
    fedoraatomic28.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    fedoraatomic28.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    fedoraatomic28.vm.provision "ansible" do |ansible|
      ansible.become = true
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
    end
  end
end
