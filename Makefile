DISTROS=centos7

docker_test:
	for distro in $(DISTROS) ; do \
        distro=$$distro ./docker-tests.sh; \
    done


empty:
	@echo ""
