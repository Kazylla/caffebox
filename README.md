# Vagrant Box for using caffe

This box definition installs necessary dependence packages to work Caffe on CentOS7 and builds Caffe source code on GitHub in appropriate configuration.

## Requirements

- Vagrant
- VirtualBox

(Tested on MacOS X only)

## Environment of this box

- CentOS 7.1

## Usage

### Building a box

```
(host) $ vagrant up
```

### Where is caffe installed to?

```
(host) $ vagrant ssh
(vm:vagrant) $ sudo su - caffe
(vm:caffe) $ cd src
(vm:caffe) $ ls
build            distribute  Makefile                 README.md
caffe.cloc       docker      Makefile.config          scripts
cmake            docs        Makefile.config.example  src
CMakeLists.txt   examples    Makefile.origin          tools
CONTRIBUTING.md  include     matlab
CONTRIBUTORS.md  INSTALL.md  models
data             LICENSE     python
```

### MNIST sample test script

```
(vm:caffe) $ cd
(vm:caffe) $ ./mnist_test.sh
I0809 09:49:27.612404 22850 caffe.cpp:279] Use CPU.
I0809 09:49:27.616170 22850 net.cpp:322] The NetState phase (1) differed from the phase (0) specified by a rule in layer mnist
...
```

## Refers to

http://caffe.berkeleyvision.org/

