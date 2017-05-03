class profile::icinga {


  package { 'icinga2':
    ensure => 'installed',
  }

  service { 'icinga2':
    ensure  => 'running',
    enable  => true,
    require => [
      Package['icinga2'],
    ],
  }

  $monitoring_plugins = ['nagios-plugins-swap', 'nagios-plugins-disk', 'nagios-plugins-load', 'nagios-plugins-procs', 'nagios-plugins-ping', 'nagios-plugins-users', 'nagios-plugins-dummy', 'nagios-plugins-http', 'nagios-plugins-ssh' ]

  package { $monitoring_plugins :
    ensure => 'installed',
  }

  exec { 'enable_graphite':
    require => Package['icinga2'],
    command => '/sbin/icinga2 feature enable graphite',
    creates => '/etc/icinga2/features-enabled/graphite.conf',
    notify => Service['icinga2'],
  }

}
