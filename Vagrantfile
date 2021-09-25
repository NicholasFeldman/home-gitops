# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = 'bento/ubuntu-20.04'

    config.vm.synced_folder '.', '/vagrant', disabled: true

    config.vm.provider "hyper-v" do |hv|
        hv.memory = 2048
        hv.cpus = 2
    end

    machines = [
        { :name => "vagrant-s-1", :ip => "192.168.50.10 "},
        { :name => "vagrant-a-1", :ip => "192.168.50.15 "},
        { :name => "vagrant-a-2", :ip => "192.168.50.16 "},
    ]

    machines.each do |opts|
        config.vm.define opts[:name] do |config|
            config.vm.hostname = opts[:name]
            config.vm.network :private_network, ip: opts[:ip]
        end
    end
end
