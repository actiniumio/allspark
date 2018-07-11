
PIP_GLOBAL_ARGS =
PIP_COMMAND_ARGS =
RM = rm -f
DOCS_SRCS := $(shell find docs/pages -name '*.md')

doc: $(DOCS_SRCS) docs/requirements.txt
	@echo "Setting up docs virtual environment"
	@EXIT_CODE=0
	@[ -d .docs_venv ] || virtualenv .docs_venv
	@source .docs_venv/bin/activate && \
	( \
		pip $(PIP_GLOBAL_ARGS) install $(PIP_COMMAND_ARGS) -r docs/requirements.txt && \
		echo "Building docs" && \
		mkdocs build -d doc || \
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

test:
	vagrant up

.PHONY: clean install test
