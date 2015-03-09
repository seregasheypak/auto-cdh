auto-cdh
========
Automated tool to get 3 running CDH5 nodes on parcels

Installation
--------

1. install vagrant 1.7.1or higher
2. install virtualbox 4.3.20 or higher
3. better to set default location for your virtualbox to SSD
4. add box: vagrant box add https://atlas.hashicorp.com/puppetlabs/boxes/centos-6.6-64-puppet --insecure
5. goto root of this project and run vagrant up

ssh using vagrant name
--------
vagrant ssh master

modify /etc/hosts and use FQDN to ssh to VMs
--------
```10.211.55.101 vm-cluster-node1.localdomain vm-cluster-node1
10.211.55.102 vm-cluster-node2.localdomain vm-cluster-node2
10.211.55.103 vm-cluster-node3.localdomain vm-cluster-node3```


ssh using  user 'devops', password 'devops' (without quotes ofcourse)
--------
```ssh devops@vm-cluster-node1.localdomain```

Sometimes you need to rerun puppet on your hosts
--------
vagrant reload --provision


repo for CM5
--------
http://archive-primary.cloudera.com/cm5/

repo for CDH5 parcels
--------
http://archive-primary.cloudera.com/cdh5/parcels/


