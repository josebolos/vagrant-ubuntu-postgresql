# vagrant-ubuntu-postgresql

This repo contains the necessary files to spin up a Ubuntu 14.04 LTS VM with PostgreSQL.

This is useful for example during the development of apps that may require a DB for testing. It avoids having to install one locally, which may not always be straightforward or desirable.


## Usage

Assumming you have [Vagrant](https://www.vagrantup.com/) installed, you just need to clone this repo and run:

`vagrant up --provision`

After the VM has finished booting and provisioning, you can access PostgreSQL on `192.168.33.20:5432`.


## What does this really do?

* Boots up an Ubuntu 14.04 LTS VM from an Ubuntu official image.
* Installs the [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin, which upgrades the VirtualBox Guest Extensions to the latest version. This ensures compatibility with mounted drives.
* Installs puppet using the shell provisioner.
* Installs PostgreSQL using the puppet provisioner and the [puppetlabs/postgresql](https://forge.puppet.com/puppetlabs/postgresql) module.
* Modifies `pg_hba.conf` so PostgreSQL listens to 192.168.33.20. This makes PostgreSQL accessible from outside the VM.
* Creates a database and assigns the proper roles to the `vagrant` user. The name of the database is configurable on [manifests/default.pp](manifests/default.pp).
