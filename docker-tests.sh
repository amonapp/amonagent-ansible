#!/bin/bash
#
# Ansible role test shim.
#
# Usage: [OPTIONS] ./tests/test.sh
#   - distro: a supported Docker distro version (default = "centos7")
#   - playbook: a playbook in the tests directory (default = "test.yml")
#   - cleanup: whether to remove the Docker container (default = true)
#   - container_id: the --name to set for the container (default = timestamp)
#   - test_idempotence: whether to test playbook's idempotence (default = true)
#
# License: MIT

# Exit on any individual command failure.
set -e

# Pretty colors.
red='\033[0;31m'
green='\033[0;32m'
neutral='\033[0m'

timestamp=$(date +%s)

# Allow environment variables to override defaults.
distro=${distro:-"ubuntu1604"}
container=${container:-"ansible:ubuntu1604"}
playbook=${playbook:-"test.yml"}
cleanup=${cleanup:-"true"}
container_id=${container_id:-$timestamp}
test_idempotence=${test_idempotence:-"false"}

## Set up vars for Docker setup.
# CentOS 7
if [ $distro = 'centos7' ]; then
  init="/usr/lib/systemd/systemd"
  opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
  container="williamyeh/ansible:centos7"
# CentOS 6
elif [ $distro = 'centos6' ]; then
  init="/sbin/init"
  opts="--privileged"
  container="williamyeh/ansible:centos6"
# Ubuntu 16.04
elif [ $distro = 'ubuntu1604' ]; then
  init="/lib/systemd/systemd"
  opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
  container="williamyeh/ansible:ubuntu16.04"
# Ubuntu 14.04
elif [ $distro = 'ubuntu1404' ]; then
  init="/sbin/init"
  opts="--privileged"
# Debian 8
elif [ $distro = 'debian8' ]; then
  init="/lib/systemd/systemd"
  opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
  container="williamyeh/ansible:debian8"
fi


# Run the container using the supplied OS.
printf ${green}"Starting Docker container: docker-$distro-ansible."${neutral}"\n"
docker pull $container
docker run --detach --volume="$PWD":/etc/ansible/roles/role_under_test:rw --name $container_id $opts $container $init

printf "\n"

# Install requirements if `requirements.yml` is present.
if [ -f "$PWD/tests/requirements.yml" ]; then
  printf ${green}"Requirements file detected; installing dependencies."${neutral}"\n"
  docker exec --tty $container_id env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/tests/requirements.yml --connection=local
fi

printf "\n"

# Test Ansible syntax.
printf ${green}"Checking Ansible playbook syntax."${neutral}
docker exec --tty $container_id env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/$playbook --syntax-check

printf "\n"

# Run Ansible playbook.
printf ${green}"Running command: docker exec $container_id env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/$playbook"${neutral}
docker exec $container_id env TERM=xterm env ANSIBLE_FORCE_COLOR=1 ansible-playbook /etc/ansible/roles/role_under_test/$playbook --connection=local

if [ "$test_idempotence" = true ]; then
  # Run Ansible playbook again (idempotence test).
  printf ${green}"Running playbook again: idempotence test"${neutral}
  idempotence=$(mktemp)
  docker exec $container_id ansible-playbook /etc/ansible/roles/role_under_test/$playbook --connection=local | tee -a $idempotence
  tail $idempotence \
    | grep -q 'changed=0.*failed=0' \
    && (printf ${green}'Idempotence test: pass'${neutral}"\n") \
    || (printf ${red}'Idempotence test: fail'${neutral}"\n" && exit 1)
fi

# Remove the Docker container (if configured).
if [ "$cleanup" = true ]; then
  printf "Removing Docker container...\n"
  docker rm -f $container_id
fi