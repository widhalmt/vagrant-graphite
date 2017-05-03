## workaround for wrong symlink in VBoxGuestAdditions
#rm -fr /sbin/mount.vboxsf && ln -s $(find /opt -name mount.vboxsf -print) /sbin/mount.vboxsf

# mostly for updates
rpm -q deltarpm 1>/dev/null || yum -y install deltarpm

rpm --import https://getfedora.org/static/352C64E5.txt
rpm -q epel-release 1>/dev/null || yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
rpm -q puppetlabs-release 1>/dev/null || yum -y install https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
rpm -q puppet 1>/dev/null || yum -y install puppet
