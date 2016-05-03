# -*- mode: ruby -*-
# vi: set ft=ruby :

## Make sure that the `vagrant-vbguest` plugin is installed
## Note this is considered a bad practice on public projects
required_plugins = %w( vagrant-vbguest )
required_plugins.each do |plugin|
    system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end


# required_plugins = %w(vagrant-share vagrant-vbguest...)
# 
# plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
# if not plugins_to_install.empty?
#   puts "Installing plugins: #{plugins_to_install.join(' ')}"
#   if system "vagrant plugin install #{plugins_to_install.join(' ')}"
#     exec "vagrant #{ARGV.join(' ')}"
#   else
#     abort "Installation of one or more plugins has failed. Aborting."
#   end
# end

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/xenial64"

    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    # config.vm.box_check_update = false

    # Update vbguest plugin
    config.vbguest.auto_update = true

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network "forwarded_port", guest: 80, host: 8080

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # config.vm.network "private_network", ip: "192.168.33.10"

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # config.vm.network "public_network"

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    config.vm.provider "virtualbox" do |vb|
        # Display the VirtualBox GUI when booting the machine
        vb.gui = false

        # Customize the amount of memory and cpus on the VM:
        vb.memory = "512"
        vb.cpus = "2"
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

    # config.vm.provision "ansible_local" do |ansible|
    #     ansible.playbook = "playbook.yml"
    #     ansible.verbose = true
    #     ansible.install = true
    # end
end
