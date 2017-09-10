# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define "main", primary: true do |node|
        node.vm.box = "ubuntu/xenial64"
        #node.vm.box = "debian/jessie64"
        #node.vm.box = "debian/wheezy64"
        #node.vm.box = "bento/centos-7.2"
        #node.vm.box = "bento/centos-6.7"

        node.vm.provision "ansible" do |ansible|
            ansible.playbook = "test.yml"
            ansible.become = true
            ansible.extra_vars = {
                ansible_python_interpreter: "/usr/bin/python3"
            }
            #ansible.verbose = "vvv"
        end
    end


    # # docker: for auto build & testing (e.g., Travis CI)
    # config.vm.define "docker" do |node|
    #     node.vm.box = "williamyeh/ubuntu-trusty64-docker"

    #     node.vm.provision "shell", inline: <<-SHELL
    #         cd /vagrant
    #         docker build  -f test/Dockerfile-ubuntu14.04  -t java_trusty   .
    #         docker build  -f test/Dockerfile-ubuntu12.04  -t java_precise  .
    #         docker build  -f test/Dockerfile-debian8      -t java_jessie   .
    #         docker build  -f test/Dockerfile-debian7      -t java_wheezy   .
    #         docker build  -f test/Dockerfile-centos7      -t java_centos7  .
    #         docker build  -f test/Dockerfile-centos6      -t java_centos6  .
    #     SHELL
    # end

end