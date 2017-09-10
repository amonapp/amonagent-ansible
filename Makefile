DISTROS=debian8

docker_test:
	for distro in $(DISTROS) ; do \
        distro=$$distro ./docker-tests.sh; \
    done


empty:
	@echo ""
