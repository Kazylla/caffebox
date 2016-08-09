#
# Cookbook Name:: caffe
# Recipe:: default
#
# Copyright 2016, Kazylla
#
# All rights reserved - Do Not Redistribute
#

git "/home/caffe/src" do
  repository "https://github.com/BVLC/caffe.git"
  revision "master"
  user "caffe"
  group "caffe"
end

bash "create Makefile.config" do
  user "caffe"
  group "caffe"
  cwd "/home/caffe/src"
  code <<-EOH
    cat Makefile.config.example | sed 's/^# CPU_ONLY := 1/CPU_ONLY := 1/;s/^# BLAS_INCLUDE := \\/path\\/to\\/your\\/blas/BLAS_INCLUDE := \\/usr\\/include/;s/^# BLAS_LIB := \\/path\\/to\\/your\\/blas/BLAS_LIB := \\/usr\\/lib64\\/atlas/' > Makefile.config
  EOH
  not_if { File.exists?("/home/caffe/src/Makefile.config") }
end

bash "create Makefile" do
  user "caffe"
  group "caffe"
  cwd "/home/caffe/src"
  code <<-EOH
    cp Makefile Makefile.origin
    cat Makefile.origin | sed 's/LIBRARIES += cblas atlas/LIBRARIES += satlas tatlas/' > Makefile
  EOH
end

bash "build caffe" do
  user "caffe"
  group "caffe"
  cwd "/home/caffe/src"
  code <<-EOH
    make all
    make test
  EOH
  not_if { File.exists?("/home/caffe/src/build/src/gtest/gtest-all.o") }
  notifies :run, 'bash[run caffe test]'
end

bash "run caffe test" do
  action :nothing
  cwd "/home/caffe/src"
  code <<-EOH
    sudo make runtest
  EOH
end

bash "create mnist dataset" do
  user "caffe"
  group "caffe"
  cwd "/home/caffe/src"
  code <<-EOH
    data/mnist/get_mnist.sh
    examples/mnist/create_mnist.sh
  EOH
  not_if { File.exists?("/home/caffe/src/examples/mnist/mnist_train_lmdb/data.mdb") }
end

bash "prepare to training" do
  user "caffe"
  group "caffe"
  cwd "/home/caffe/src"
  code <<-EOH
    cp examples/mnist/lenet_solver.prototxt examples/mnist/lenet_solver.prototxt.origin
    cat examples/mnist/lenet_solver.prototxt.origin | sed 's/solver_mode: GPU/solver_mode: CPU/' > examples/mnist/lenet_solver.prototxt
  EOH
  not_if { File.exists?("/home/caffe/src/examples/mnist/lenet_solver.prototxt.origin") }
end

bash "execute training" do
  user "caffe"
  group "caffe"
  cwd "/home/caffe/src"
  code <<-EOH
    examples/mnist/train_lenet.sh
  EOH
  only_if { Dir.glob('/home/caffe/src/examples/mnist/lenet_iter_*.caffemodel').empty? }
end

cookbook_file "put mnist test script" do
  owner "caffe"
  group "caffe"
  mode '0755'
  action :create
  source "mnist_test.sh"
  path "/home/caffe/mnist_test.sh"
end
