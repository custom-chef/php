#
# Cookbook:: php
# Attributes:: default

# for Amazon Linux EC2

lib_dir = 'lib'
default['php']['install_method'] = 'package'
default['php']['directives'] = {}
default['php']['bin'] = 'php'

default['php']['pear'] = 'pear'
default['php']['pecl'] = 'pecl'

default['php']['version'] = '7.0.21'

default['php']['url'] = 'http://us1.php.net/get'
default['php']['checksum'] = '8bc7d93e4c840df11e3d9855dcad15c1b7134e8acf0cf3b90b932baea2d0bde2'
default['php']['prefix_dir'] = '/usr/local'
default['php']['enable_mod'] = '/usr/sbin/php5enmod'
default['php']['disable_mod'] = '/usr/sbin/php5dismod'

default['php']['ini']['template'] = 'php.ini.erb'
default['php']['ini']['cookbook'] = 'php'

default['php']['fpm_socket']        = '/var/run/php70-fpm.sock'
default['php']['curl']['package']   = 'php70-curl'
default['php']['apcu']['package']   = 'php70-apcu'
default['php']['gd']['package']     = 'php70-gd'

lib_dir = node['kernel']['machine'] =~ /x86_64/ ? 'lib64' : 'lib'
default['php']['conf_dir']      = '/etc'
default['php']['ext_conf_dir']  = '/etc/php.d'
default['php']['fpm_user']      = 'nobody'
default['php']['fpm_group']     = 'nobody'
default['php']['fpm_listen_user']   = 'nobody'
default['php']['fpm_listen_group']  = 'nobody'
default['php']['ext_dir']           = "/usr/#{lib_dir}/php/modules"
default['php']['src_deps']      = %w(bzip2-devel libc-client-devel curl-devel freetype-devel gmp-devel libjpeg-devel krb5-devel libmcrypt-devel libpng-devel openssl-devel t1lib-devel libxml2-devel libxslt-devel zlib-devel)
default['php']['packages']      = %w(php70 php70-gd php70-mbstring php70-mcrypt php70-imap php-pear)
default['php']['fpm_package']   = 'php70-fpm'
default['php']['mysql']['package'] = 'php70-mysqlnd'
default['php']['fpm_pooldir'] = '/etc/php-fpm.d'
default['php']['fpm_default_conf'] = '/etc/php-fpm.d/www.conf'
default['php']['fpm_service'] = 'php-fpm'
if node['php']['install_method'] == 'package'
  default['php']['fpm_user']      = 'apache'
  default['php']['fpm_group']     = 'apache'
  default['php']['fpm_listen_user'] = 'apache'
  default['php']['fpm_listen_group'] = 'apache'
end

default['php']['configure_options'] = %W(--prefix=#{node['php']['prefix_dir']}
                                         --with-libdir=#{lib_dir}
                                         --with-config-file-path=#{node['php']['conf_dir']}
                                         --with-config-file-scan-dir=#{node['php']['ext_conf_dir']}
                                         --with-pear
                                         --enable-fpm
                                         --with-fpm-user=#{node['php']['fpm_user']}
                                         --with-fpm-group=#{node['php']['fpm_group']}
                                         --with-zlib
                                         --with-openssl
                                         --with-kerberos
                                         --with-bz2
                                         --with-curl
                                         --enable-ftp
                                         --enable-zip
                                         --enable-exif
                                         --with-gd
                                         --enable-gd-native-ttf
                                         --with-gettext
                                         --with-gmp
                                         --with-mhash
                                         --with-iconv
                                         --with-imap
                                         --with-imap-ssl
                                         --enable-sockets
                                         --enable-soap
                                         --with-xmlrpc
                                         --with-libevent-dir
                                         --with-mcrypt
                                         --enable-mbstring
                                         --with-t1lib
                                         --with-mysql
                                         --with-mysqli=/usr/bin/mysql_config
                                         --with-mysql-sock
                                         --with-sqlite3
                                         --with-pdo-mysql
                                         --with-pdo-sqlite)
