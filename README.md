To build a following of the environment.

* PHP7
* Apache
* MySQL5.7

# Usage

    % chef-client --local-mode -j nodes/chef.json -c chef.rb


If you use rvm, you enter this command.

    % rvmsudo_secure_path=1 rvmsudo chef-client --local-mode -j nodes/chef.json -c chef.rb

# Sample Vagrantfile

If you use vagrant, this is a sample of Vagrantfile.

```
  % vi Vagrantfile
  # config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :private_network, ip: "192.168.33.10"

      :
      :
      :

  first_install_script = <<SCRIPT
    # TimeZone : UTC -> JST
    timedatectl set-timezone Asia/Tokyo

    # install rvm, ruby2.3
    gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -L https://get.rvm.io | sudo bash -s stable
    gpasswd -a vagrant rvm
SCRIPT

  second_install_script = <<SCRIPT
    sudo -i -u vagrant rvm install 2.3 --default
SCRIPT

  third_install_script = <<SCRIPT
    # gem install for chef
    sudo -i -u vagrant gem install bundler
    sudo -i -u vagrant gem install chef
    sudo -i -u vagrant gem install knife-solo
SCRIPT

  fourth_install_script = <<SCRIPT
    # install git for to download cookbook repository
    yum -y update
    yum -y install git

    sudo -u vagrant git clone https://github.com/eidera/chef-php-env.git

    # execute chef
    cd /home/vagrant/chef-php-env && rvmsudo_secure_path=1 /usr/local/rvm/bin/rvmsudo chef-client --local-mode -j nodes/chef.json -c chef.rb
SCRIPT

  config.vm.provision :shell, :inline => first_install_script
  config.vm.provision :shell, :inline => second_install_script
  config.vm.provision :shell, :inline => third_install_script
  config.vm.provision :shell, :inline => fourth_install_script
```
