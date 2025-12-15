.PHONY: test

install_uv:
	pip install -U pip uv -q

install_deps:
	uv sync --all-extras

install_precommit:
	uv run pre-commit install
	uv run pre-commit gc

update_precommit:
	uv run pre-commit autoupdate
	uv run pre-commit gc

install: install_uv install_deps

precommit:
	uv run pre-commit run --all-files

test:
	uv run pytest

tests: test

all: precommit tests
