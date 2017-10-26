#
# Cookbook:: php
# Recipe:: default

%w(php70 php70-common php70-devel php70-mbstring php70-mcrypt php7-pear).each do |pkg|
    package pkg
end

if node['debug']
    execute 'pecl7 install xdebug' do
        command 'pecl7 install xdebug'
        not_if { File.exists?('/usr/lib64/php/7.0/modules/xdebug.so') }
    end

    template '/etc/php-7.0.d/99-xdebug.ini' do
        source '99-xdebug.ini.erb'
        mode 0644
        owner 'root'
        group 'root'
    end

    execute 'pecl7 install -f xhprof' do
        command 'pecl7 install -f xhprof'
        not_if { Dir.exists?('/usr/share/pear7/xhprof_lib') }
    end
end

# /etc/php-7.0.d/

include_recipe 'php::ini'

execute "install composer" do
    user "root"
    command <<-EOC
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
        php composer-setup.php --install-dir=/usr/local/bin --filename=composer
        php -r "unlink('composer-setup.php');"
    EOC
    not_if { File.exists?('/usr/local/bin/composer') }
end

execute "install deployer" do
    user "root"
    command <<-EOC
        curl -LO https://deployer.org/deployer.phar
        mv deployer.phar /usr/local/bin/dep
        chmod +x /usr/local/bin/dep
    EOC
    not_if { File.exists?('/usr/local/bin/dep') }
end
