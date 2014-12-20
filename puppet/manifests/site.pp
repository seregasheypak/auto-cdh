$cm_version = '4.8.0'

define append_if_no_such_line($file, $line, $refreshonly = 'false') {
  exec { "/bin/echo '$line' >> '$file'":
    unless      => "/bin/grep -Fxqe '$line' '$file'",
    path        => "/bin",
    refreshonly => $refreshonly,
  }
}

node default {
  include sudo

  sudo::conf { 'wheel':
    priority  => 10,
    content   => "%wheel    ALL=(ALL)   NOPASSWD: ALL\n",
  }

  class { timezone:
    zone => "Europe/Moscow",
  }

  class { 'selinux':
    mode => 'disabled',
  }

  service { "iptables":
    enable => false,
    ensure => stopped,
    hasrestart => true,
    hasstatus => true,
  }

  service { "ip6tables":
    enable => false,
    ensure => stopped,
    hasrestart => true,
    hasstatus => true,
  }

  append_if_no_such_line { sysctl_all_ipv6:
    file => "/etc/sysctl.conf",
    line => "net.ipv6.conf.all.disable_ipv6 = 1"
  }

  append_if_no_such_line { sysctl_default_ipv6:
    file => "/etc/sysctl.conf",
    line => "net.ipv6.conf.default.disable_ipv6 = 1"
  }

}

node 'vm-cluster-node1.localdomain' inherits default {
  class { 'cloudera':
    cm_server_host => 'vm-cluster-node1.localdomain',
    use_parcels    => true,
  } ->
  class { 'cloudera::cm::server': }
}

node 'vm-cluster-node2.localdomain' inherits default {
  class { 'cloudera':
    cm_server_host => 'vm-cluster-node1.localdomain',
    use_parcels    => true,
  }
}

node 'vm-cluster-node3.localdomain' inherits default {
  class { 'cloudera':
    cm_server_host => 'vm-cluster-node1.localdomain',
    use_parcels    => true,
  }
}


