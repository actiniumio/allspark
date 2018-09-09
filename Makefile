
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

test-ubuntu14:
	vagrant up ubuntu14 --provision

test-fedoraserver28:
	vagrant up fedoraserver28 --provision

test-fedoraatomic28:
	vagrant up fedoraatomic28 --provision

lint:
	./.circleci/lint.sh

test: test-centos7

.PHONY: clean install lint test doc-dev test-centos7 test-ubuntu14 test-fedoraatomic28 test-fedoraserver28
