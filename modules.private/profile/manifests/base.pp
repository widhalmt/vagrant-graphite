class profile::base {

  stage { 'first': } -> stage { 'repos': } -> Stage['main']

  package { 'vim-enhanced':
    ensure => 'installed',
  }

  package { 'ntp':
    ensure => 'installed',
  }

  package { 'deltarpm':
    ensure => 'installed',
  }

  service { 'ntpd':
    ensure => 'running',
    enable => true,
    require => Package['ntp'],
  }

  service { 'firewalld':
    ensure => 'stopped',
    enable => false,
  }
  class { 'repos::icinga':
    stage => 'repos',
  }

  class { 'repos::epel':
    stage => 'repos',
  }

  exec { 'selinux-disable':
    path    => '/usr/sbin:/usr/bin',
    command => 'setenforce 0',
    unless  => 'getenforce |/bin/grep -n Permissive 2>&1>/dev/null',
  }
  file_line { 'selinux-disable':
    path   => '/etc/sysconfig/selinux',
    line  => 'SELINUX=permissive',
    match => '^SELINUX=',
  }


}

