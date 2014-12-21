
vm_mem = "2048"

$host_script = <<SCRIPT
#!/bin/bash

mkdir -p /etc/puppet/modules;
puppet module install puppetlabs/stdlib;
puppet module install razorsedge/cloudera;

cat > /etc/hosts <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

10.211.55.101 vm-cluster-node1.localdomain vm-cluster-node1
10.211.55.102 vm-cluster-node2.localdomain vm-cluster-node2
10.211.55.103 vm-cluster-node3.localdomain vm-cluster-node3
EOF
SCRIPT

$API_VERSION = "2"
Vagrant.configure($API_VERSION) do |config|

  config.vm.provision :shell, :inline => $host_script
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path = 'puppet/modules'
    puppet.options = "--verbose --debug"
    puppet.facter = {
        "os_maj_version"  => '6',
        "architecture"    => 'x86_64'
    }
  end

  config.vm.define :master do |master|
    master.vm.box = "puppetlabs/centos-6.5-64-puppet"
    master.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-node1"
      v.customize ["modifyvm", :id, "--memory", vm_mem]
    end
    master.vm.hostname = "vm-cluster-node1.localdomain"
    master.vm.network :private_network, ip: "10.211.55.101"
  end

  config.vm.define :slave1 do |slave1|
    slave1.vm.box = "puppetlabs/centos-6.5-64-puppet"
    slave1.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-node2"
      v.customize ["modifyvm", :id, "--memory", vm_mem]
    end
    slave1.vm.hostname = "vm-cluster-node2.localdomain"
    slave1.vm.network :private_network, ip: "10.211.55.102"
  end

  config.vm.define :slave2 do |slave2|
    slave2.vm.box = "puppetlabs/centos-6.5-64-puppet"
    slave2.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-node3"
      v.customize ["modifyvm", :id, "--memory", vm_mem]
    end
    slave2.vm.hostname = "vm-cluster-node3.localdomain"
    slave2.vm.network :private_network, ip: "10.211.55.103"
  end

end
