# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
<<<<<<< HEAD
<<<<<<< HEAD
  config.vm.define "centos7", primary: true do |centos7|
    centos7.vm.box = "actinium/centos7"
    config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 8443, host: 8443, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 2223, host: 2223, host_ip: "127.0.0.1"
    centos7.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    centos7.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
      ansible.extra_vars = {
        haproxy_http_port:  8080,
        haproxy_https_port: 8443
      }
    end
  end
  config.vm.define "ubuntu14", autostart: false do |ubuntu14|
    ubuntu14.vm.box = "actinium/ubuntu14"
    config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 8443, host: 8443, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 2223, host: 2223, host_ip: "127.0.0.1"
    ubuntu14.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    ubuntu14.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
      ansible.extra_vars = {
        haproxy_http_port:  8080,
        haproxy_https_port: 8443
      }
    end
  end
<<<<<<< HEAD
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
=======
  config.vm.define "fedoraserver28", autostart: false do |fedoraserver28|
    fedoraserver28.vm.box = "actinium/fedoraserver28"
    config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 8443, host: 8443, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 2223, host: 2223, host_ip: "127.0.0.1"
    fedoraserver28.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    fedoraserver28.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
      ansible.extra_vars = {
        haproxy_http_port:  8080,
        haproxy_https_port: 8443
      }
    end
  end
  config.vm.define "fedoraatomic28", autostart: false do |fedoraatomic28|
    fedoraatomic28.vm.box = "actinium/fedoraatomic28"
    config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 8443, host: 8443, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 2223, host: 2223, host_ip: "127.0.0.1"
    fedoraatomic28.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    fedoraatomic28.vm.provision "ansible" do |ansible|
      ansible.become = true
>>>>>>> 7a87dd7... Take part of the new boxes
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
      ansible.extra_vars = {
        haproxy_http_port:  8080,
        haproxy_https_port: 8443
      }
=======
  config.vm.define "centos", primary: true do |centos|
    centos.vm.box = "centos/7"
    centos.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
    centos.vm.provider "virtualbox" do |vb|
=======
  config.vm.define "centos7", primary: true do |centos7|
    centos7.vm.box = "centos/7"
    centos7.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
    centos7.vm.provider "virtualbox" do |vb|
>>>>>>> bd69b91... Update Vagrant & Makefile to take part of the different system
      vb.memory = "2048"
    end
    centos7.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
    end
  end
  config.vm.define "ubuntu14", autostart: false do |ubuntu14|
    ubuntu14.vm.box = "actinium/trusty64"
    ubuntu14.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
    ubuntu14.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    ubuntu14.vm.provision "ansible" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook = "install.yml"
>>>>>>> 243d67f... Update Vagrantfile with actinium/trusty64 box
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
