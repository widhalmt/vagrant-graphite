# vagrant-graphite
Testbed for Graphite setups

This is supposed only for internal tests. You are welcome to use it if you see fit but I will most certainly not change it to fit your needs for now.

= Usage =

== VirtualBox Guest Additions ==

You will need the `vbguest` plugin for vagrant if you run these boxes on VirtualBox.

    vagrant plugin install vagrant-vbguest 

== Additional Puppet Modules ==

Before starting the boxes you will need to install the missing Puppet modules from the forge.

    r10k puppetfile install

== Starting the Boxes ==

After the beforementioned steps you simply need to start the boxes.

    vagrant up

== Logging in ==

You can use the standard ssh commands to access the boxes

    vagrant ssh icinga2
    vagrant ssh graphite

== Accessing the Webinterfaces ==

Ports are mapped to the host. You can access Graphite-Web via `http://localhost:8003`

= Known Issues =

== Inconsistent yum repos ==

One of the yum repositories is not configured with the others. This is just for portability of this special module.
