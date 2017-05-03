class role::icinga {
  include 'profile::icinga'
  include 'profile::carbon-relay-ng'
  include 'profile::base'
}

