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
  config.vm.define "rhel7", autostart: false do |rhel7|
<<<<<<< HEAD
    rhel7.vm.box = "generic/rhel7"
=======
    rhel7.vm.box = "roboxes/rhel7"
>>>>>>> bd69b91... Update Vagrant & Makefile to take part of the different system
    rhel7.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
    rhel7.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    rhel7.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
    end
  end
end
