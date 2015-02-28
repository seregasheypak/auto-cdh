$cm_version = '5.3.2'

define append_if_no_such_line($file, $line, $refreshonly = 'false') {
  exec { "/bin/echo '$line' >> '$file'":
    unless      => "/bin/grep -Fxqe '$line' '$file'",
    path        => "/bin",
    refreshonly => $refreshonly,
  }
}

node default {

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
    install_cmserver => true,
    cdh_version => '5.2.1',
  }
}

node 'vm-cluster-node2.localdomain' inherits default {
  class { 'cloudera':
    cm_server_host => 'vm-cluster-node1.localdomain',
  }
}

node 'vm-cluster-node3.localdomain' inherits default {
  class { 'cloudera':
    cm_server_host => 'vm-cluster-node1.localdomain',
  }
}


