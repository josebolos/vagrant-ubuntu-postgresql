node default {
    class { 'postgresql::server': }

    postgresql::server::role { 'vagrant':
        password_hash => postgresql_password('vagrant', 'vagrant')
    }
}
