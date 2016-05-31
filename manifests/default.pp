node default {
    # Change the following to the name of your database
    $database = 'mydb'
    $user = 'vagrant'
    $password = 'vagrant'

    class { 'postgresql::server':
        listen_addresses => '*'
    }

    postgresql::server::role { $user :
        password_hash => postgresql_password($user, $password)
    }

    postgresql::server::db { $database :
        user     => $user,
        password => postgresql_password($user, $password),
        require  => Class['postgresql::server']
    }

    postgresql::server::database_grant { $database :
        privilege => 'ALL',
        db        => $database,
        role      => $user,
        require   => Class['postgresql::server']
    }

    postgresql::server::pg_hba_rule { 'allow application network to access app database':
        description => "Open up postgresql for access from 192.168.33.20/24",
        type        => 'host',
        database    => $database,
        user        => $user,
        address     => '192.168.33.20/24',
        auth_method => 'md5',
        target      => '/etc/postgresql/9.3/main/pg_hba.conf'
    }
}
