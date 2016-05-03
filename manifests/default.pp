package { 'postgresql' :
    ensure => latest
}


service { 'postgresql' :
    require => [
        Package['postgresql']
    ],
    ensure => running
}
