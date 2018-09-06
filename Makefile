
PIP_GLOBAL_ARGS =
PIP_COMMAND_ARGS =
RM = rm -f
DOCS_SRCS := $(shell find docs/nav -name '*.md')

.docs_venv:  docs/requirements.txt
	@echo "Setting up docs virtual environment"
	@EXIT_CODE=0
	@[ -d .docs_venv ] || virtualenv .docs_venv
	@. .docs_venv/bin/activate && \
	( \
		pip $(PIP_GLOBAL_ARGS) install $(PIP_COMMAND_ARGS) -r docs/requirements.txt || \
		EXIT_CODE=1 \
	); deactivate
	@exit $(EXIT_CODE)

doc: $(DOCS_SRCS) .docs_venv
	@. .docs_venv/bin/activate && \
	( \
		echo "Building docs" && \
		mkdocs build -d doc || \
		EXIT_CODE=1 \
	); deactivate
	@exit $(EXIT_CODE)

doc-dev: .docs_venv
	@. .docs_venv/bin/activate && \
	( \
		mkdocs serve || \
		EXIT_CODE=1 \
	); deactivate
	@exit $(EXIT_CODE)

clean:
	@echo "Removing documentation artifacts"
	@$(RM) -r doc .docs_venv
	@echo "Removing Ansible retry files"
	@find . -name '*.retry' | xargs $(RM)
	@echo "Tearing down development Vagrant box."
	@(which vagrant >/dev/null && vagrant destroy -f) || echo "Vagrant not installed, skipping VM destruction."

test-centos7:
	vagrant up centos7 --provision
<<<<<<< HEAD
=======

test-ubuntu:
	vagrant up ubuntu14 --provision

<<<<<<< HEAD
<<<<<<< HEAD
test-rhel7:
<<<<<<< HEAD
        vagrant up rhel7 --provision
>>>>>>> bd69b91... Update Vagrant & Makefile to take part of the different system
=======
	vagrant up rhel7 --provision
>>>>>>> 34c6c3b... Update Makefile

test-ubuntu14:
	vagrant up ubuntu14 --provision

=======
>>>>>>> 7a87dd7... Take part of the new boxes
test-fedoraserver28:
	vagrant up fedoraserver28 --provision

test-fedoraatomic28:
	vagrant up fedoraatomic28 --provision

<<<<<<< HEAD
=======
>>>>>>> 6854c14... Update Makefile
=======
>>>>>>> 7a87dd7... Take part of the new boxes
test: test-centos7

.PHONY: clean install test doc-dev test-centos7 test-ubuntu14
