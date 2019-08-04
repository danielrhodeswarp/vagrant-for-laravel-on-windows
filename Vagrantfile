# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # CUSTOM VARIABLES
  custom_vm_name = "cool_new_project" #use only alphanum and underscores (ALSO used for the MySQL schema name)
  custom_ip = "192.168.23.18" #make different to all the other Vagrant IPs in your HOSTS file
  custom_local_domain = "cool-new-project.test"   #don't use .dev as this causes HSTS issues on local browser
  custom_project_name = "cool-new-project"   #used for certain folder and file names (or "repo name" if you like)
  custom_use_tls = "this setting is a TODO and not yet acted upon"
  # ----

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "laravel/homestead"
  #config.vm.box_version = "7.0.0"

  # our name for the VM (TODO use custom_vm_name)
  #config.vm.define :some_vm_name_as_a_ruby_symbol do |t|
  config.vm.define custom_vm_name do |t|
  end

  config.vm.post_up_message = <<-HEREDOC
    ----------------------------------------------------------------
    The following URLs are now useable and useful (*):

    http://#{custom_local_domain}/phpinfo.php  (PHP configuration)
    http://#{custom_local_domain}/adminer.php  (data browser tool)
    http://#{custom_local_domain}              (the app itself!)

    (*) Provided that they are mapped to #{custom_ip}
        in your HOSTS file

    You will need to kickstart Laravel for development thus:

    vagrant ssh
    cd /var/www/vhosts/#{custom_project_name}/laravel
    php artisan migrate
    ----------------------------------------------------------------
  HEREDOC

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: custom_ip  #make different from other Vagrant private IPs!

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  #application core
  config.vm.synced_folder ".", "/var/www/vhosts/#{custom_project_name}"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
     # Customize the amount of memory on the VM:
     #vb.memory = "1536"
     vb.memory = "1536"

     #############vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//var/www/vhosts/gift-card-customer-app", "1"]
  end



  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  # copy our local vhost config over into the machine (annoyingly this runs as 'vagrant' user)
  #config.vm.provision "file", source: "vagrant/apache_config.txt", destination: "/home/vagrant/dining-programme.vhost.conf"
  config.vm.provision "file", source: "vagrant/copy_into/nginx_config.txt", destination: "/home/vagrant/#{custom_project_name}.vhost.conf"

  # see this separate file for initial provisioning stuff
  config.vm.provision "shell", path: "vagrant/provision_vm/root_provisioner.sh", args: [custom_project_name, custom_vm_name, custom_local_domain]

  # @link https://www.vagrantup.com/docs/provisioning/shell.html
  config.vm.provision "shell", path: "vagrant/provision_vm/install_laravel.sh", privileged: false, args: [custom_project_name]
  config.vm.provision "shell", path: "vagrant/provision_vm/kickstart_dev_env.sh", privileged: false, args: [custom_project_name]
  config.vm.provision "shell", path: "vagrant/provision_vm/install_composer.sh", privileged: false, args: [custom_project_name]
  config.vm.provision "shell", path: "vagrant/provision_vm/run_composer_install.sh", privileged: false, args: [custom_project_name]
  config.vm.provision "shell", path: "vagrant/provision_vm/kickstart_laravel.sh", privileged: false, args: [custom_project_name]
  config.vm.provision "shell", path: "vagrant/provision_vm/run_npm_install.sh", privileged: false, args: [custom_project_name]

end
