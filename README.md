auto-cdh
========
Automated tool to get 3 running CDH5 nodes on parcels

how-to set modules to temp dir, Effective Puppet Module Management in Vagrant
http://blog.james-carr.org/2014/05/05/effective-puppet-module-management-in-vagrant/

vagrant-librarian-puppet 0.7.1
https://rubygems.org/gems/vagrant-librarian-puppet

how-to add librarian to vm
https://github.com/mindreframer/vagrant-puppet-librarian
https://rshestakov.wordpress.com/2014/02/02/how-to-manage-public-and-private-puppet-modules-with-vagrant/



install vagrant 1.7.1
install virtualbox 4.3.20
set VM default location for VirtualBox: /home/ssa/mnt/corsair

add default CENTSOs box w/o
vagrant box add centos-64-x64-vbox4210-nocm.box http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box

# puppetlabs/centos-6.5-64-puppet
vagrant box add https://atlas.hashicorp.com/puppetlabs/boxes/centos-6.5-64-puppet --insecure

# run vagrant
vagrant up

# goto vm using ssh
vagrant ssh master

# rerun puppet on vagrant VM host (requires vagrant shh <vm_host>)
puppet apply --verbose --debug

# rerun provisioning on VMs
vagrant reload --provision


#repo for CM5
http://archive-primary.cloudera.com/cm5/

#repo for CDH5 parcels
http://archive-primary.cloudera.com/cdh5/parcels/

#some tool to run for cloudera cluster provision
https://github.com/gdgt/cmapi



