# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provision "file", source: "./app.tar.gz", destination: "/tmp/app.tar.gz"
  config.vm.provision "file", source: "./yum_pkgs.txt", destination: "/tmp/yum_pkgs.txt"
  config.vm.provision "shell", path: "provision.sh"
end