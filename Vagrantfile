# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "centos", primary: true do |centos|
    centos.vm.box = "centos/7"
    centos.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
    centos.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    centos.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
    end
  end
  config.vm.define "ubuntu", autostart: false do |ubuntu|
    ubuntu.vm.box = "actinium/trusty64"
    ubuntu.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
    ubuntu.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    ubuntu.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
    end
  end
end
