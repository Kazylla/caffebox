require_relative 'chef-repo/caffe.rb'

Vagrant.configure(2) do |config|
  config.vm.box = "centos7"
  config.vm.box_url = "https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box"

  CaffeChef.configure(config)
end
