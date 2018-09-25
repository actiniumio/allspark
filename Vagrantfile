# -*- mode: ruby -*-
# vi: set ft=ruby :

allspark_boxes = {
  "centos7" => "actinium/centos7",
  "ubuntu14" => "actinium/ubuntu14",
  "fedoraserver28" => "actinium/fedoraserver28",
  "fedoraatomic28" => "actinium/fedoraatomic28",
}



Vagrant.configure("2") do |config|
  $x=0
  allspark_boxes.keys.each do |allspark_box|

    config.vm.define "#{allspark_box}", primary: true do |b|

      config.vm.network "forwarded_port", guest: 8080, host: 8080 + $x, host_ip: "127.0.0.1"
      config.vm.network "forwarded_port", guest: 8443, host: 8443 + $x, host_ip: "127.0.0.1"
      config.vm.network "forwarded_port", guest: 2223, host: 2223 + $x, host_ip: "127.0.0.1"

      b.vm.box = allspark_boxes[allspark_box]
      b.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
      end
      b.vm.provision "ansible" do |ansible|
        ansible.verbose = "vvv"
        ansible.playbook = "install.yml"
        ansible.extra_vars = {
          haproxy_http_port:  8080,
          haproxy_https_port: 8443
        }
      end
    end
    $x=$x+1
  end
end
