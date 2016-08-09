#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2016, Kazylla
#
# All rights reserved - Do Not Redistribute
#
yum_package "epel-release"
yum_package [
  "python",
  "python-devel",
  "unzip",
  "gtk+-devel",
  "gtk2-devel",
  "gflags-devel",
  "glog-devel",
  "lmdb-devel",
  "atlas-devel",
  "protobuf-devel",
  "snappy-devel",
  "opencv-devel",
  "boost-devel",
  "leveldb-devel",
  "hdf5-devel"] do
    options "--enablerepo=epel"
end

user 'caffe' do
  comment 'Caffe user'
  home '/home/caffe'
  shell '/bin/bash'
end
