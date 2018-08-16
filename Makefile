
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
	@find ./playbooks/ -name '*.retry' | xargs $(RM)
	@echo "Tearing down development Vagrant box."
	@(which vagrant >/dev/null && cd playbooks/ && vagrant destroy -f) || echo "Vagrant not installed, skipping VM destruction."

test:
<<<<<<< HEAD
<<<<<<< HEAD
	vagrant up --provision
=======
	cd playbooks/ && vagrant up --provision
>>>>>>> e0d5f74... Move Core to playbooks folder & Update Makefile & and CircleCI
=======
	cd playbooks/ && vagrant up --provision
>>>>>>> 60b89d2aa86df5fc1edac313ed83c85153eed539

.PHONY: clean install test doc-dev
