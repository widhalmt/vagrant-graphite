class profile::carbon-relay-ng (
  $carbon_cache_ip = '192.168.5.20',
  $carbon_cache_port = '2003',
) {

  package { 'pygpgme':
    ensure => 'installed',
  }

  package { 'yum-utils':
    ensure => 'installed',
  }

  yumrepo { 'raintank':
    descr => 'Raintank Repo for Carbon-Relay-NG',
    baseurl => 'https://packagecloud.io/raintank/raintank/el/7/$basearch',
    failovermethod => 'priority',
    enabled => '1',
    gpgcheck => '0',
    gpgkey => 'https://packagecloud.io/raintank/raintank/gpgkey',
    require => [
      Package['pygpgme'],
      Package['yum-utils'],
    ],
  }

  package{ 'carbon-relay-ng':
    ensure => 'installed',
    require => Yumrepo['raintank'],
  }

  file{ '/var/spool/carbon-relay-ng':
    ensure => 'directory',
  }

  file{ '/var/run/carbon-relay-ng':
    ensure => 'directory',
  }

  file { 'carbon-relay-ng.conf':
    ensure => "file",
    notify => Service['carbon-relay-ng'],
    #source => 'puppet:///modules/profile/carbon-relay-ng.conf',
    content => template('profile/carbon-relay-ng.conf.erb'),
    path   => '/etc/carbon-relay-ng/carbon-relay-ng.conf',
    require => Package['carbon-relay-ng'],
  }

  service { 'carbon-relay-ng':
    ensure => 'running',
    enable => true,
    require => [
      File['/var/spool/carbon-relay-ng'],
      File['/var/run/carbon-relay-ng'],
      File['carbon-relay-ng.conf'],
      Package['carbon-relay-ng'],
    ],
  }
}
