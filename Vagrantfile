# coding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.provider 'virtualbox'
  config.vm.box = "centos/7"
  config.vm.synced_folder '.', '/vagrant'
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.define 'localhost' do |machine|
    machine.vm.provision :ansible_local do |ansible|
      ansible.playbook       = "playbooks/install.yml"
      ansible.install_mode = "pip"
      ansible.version = "2.5.5"
      #ansible.limit          = "all"
      ansible.verbose = "vvv"
      ansible.inventory_path = "inventory"
    end
  end
end
