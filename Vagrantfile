# -*- mode: ruby -*-
# vi: set ft=ruby :

## Make sure that the `vagrant-vbguest` plugin is installed
## Note this is considered a bad practice on public projects
required_plugins = %w( vagrant-vbguest )

plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
    puts "Installing plugins: #{plugins_to_install.join(' ')}"
    if system "vagrant plugin install #{plugins_to_install.join(' ')}"
        exec "vagrant #{ARGV.join(' ')}"
    else
        abort "Installation of one or more plugins has failed. Aborting."
    end
end


Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.vm.hostname = "vagrant-ubuntu-postgresql.test"

    # Update vbguest plugin
    config.vbguest.auto_update = true

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network "private_network", ip: "192.168.33.20"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    config.vm.provider "virtualbox" do |vb|
        # Display the VirtualBox GUI when booting the machine?
        vb.gui = false

        # Customize the amount of memory and cpus on the VM:
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--groups", "/vagrant-ubuntu"]
        vb.customize ["modifyvm", :id, "--name", "vagrant-ubuntu-postgresql.test"]
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
    end

    # Provisioning
    # Install puppet using the shell provisioner
    # So we can use puppet to provision the rest of the machine
    config.vm.provision "shell", :inline => <<-SHELL
        apt-get update
        apt-get install -y puppet
    SHELL

    # Provision everything else with puppet
    config.vm.provision "puppet" do |puppet|
        puppet.options = "--verbose --debug"
    end
end
