# -*- mode: ruby -*-
# vi: set ft=ruby :
#
nodes = { 'icinga2'  => {
            :box       => 'centos/7',
            :memory    => '1024',
            :ip     => '192.168.5.10',
          },
          'graphite'  => {
            :box       => 'centos/7',
            :memory    => '1024',
            :ip     => '192.168.5.20',
          },
}


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  nodes.each_pair do |name, options|
    config.vm.define name do |node_config|
      node_config.vbguest.auto_reboot = true
      node_config.vm.box = options[:box]
      node_config.vm.hostname = name
      node_config.vm.box_url = options[:url] if options[:url]
      node_config.vm.network :private_network, :adapter => 2, ip: options[:ip]
      node_config.vm.provider :virtualbox do |vb|
        vb.linked_clone = true if Vagrant::VERSION =~ /^1.8/
        vb.name = name
        vb.gui = false
        vb.customize ["modifyvm", :id,
          "--groups", "/Graphite",
          "--memory", "256",
          "--audio", "none",
          "--usb", "on",
          "--usbehci", "off",
          "--nic2", "intnet",
          "--intnet2", "intnet",
        ]
        vb.memory = options[:memory] if options[:memory]
      end

      node_config.vm.provision :shell,
      :path => 'scripts/pre-install.sh'
      node_config.vm.provision :puppet do |puppet|
        #puppet.environment = ENV['VAGRANT_PUPPET_ENV'] if ENV['VAGRANT_PUPPET_ENV']
        puppet.manifests_path = "manifests"
        puppet.module_path = [ "modules.private", "modules" ]
        #puppet.hiera_config_path = "hiera.yaml"
      end
    end
  end


  config.vm.define "icinga2" do |icinga2|
    icinga2.vm.network "forwarded_port", guest: 5601, host: 5601
    icinga2.vm.network "forwarded_port", guest: 9200, host: 9200
    icinga2.vm.network "forwarded_port", guest: 9600, host: 9600
    #icinga2.vm.synced_folder "./logstash-indexer", "/etc/logstash/conf.d"
  end
  config.vm.define "graphite" do |graphite|
    graphite.vm.network "forwarded_port", guest: 8003, host: 8003
    #graphite.vm.synced_folder "./logstash-indexer", "/etc/logstash/conf.d"
  end

end
