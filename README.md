Description of the repo here

## Repo Structure

Generated using `tree -L 2 -I "_*"` (need to install via `brew install tree`)

```bash
.
├── LICENSE
├── Makefile
├── README.md
├── poetry.lock
├── poetry.toml
├── pyproject.toml
├── src
│   └── package
└── test
    └── test_example.py
```

## Contributing

1. Clone out the package
2. Ensure you have a python 3.11 installation active.
3. I would recommend doing this via `brew install pyenv`, and then run `pyenv install 3.11` to install, and then run `pyenv shell 3.11.8` (or whatever version installed)
4. Run make install
    1. This will update pip, poetry and then install via poetry
    2. It will also set up the .venv folder with a symlink to the right python version, so you wont have to run the pyenv shell again
5. Ensure that your VSCode Python interpreter is pointing to the python in `.venv/bin/python`
6. Validate all your code formatting and tests via `make precommit`, `make tests` (or `make all` to run both) manually.

## Adding dependencies

1. Dependencies are added to the `pyproject.toml` file under the `[tool.poetry.dependencies]` section. It is very simple, let's say
you want to add pandas v2, you just add the line `pandas= "^2.0.0"`.
2. When dependencies are updated, you need to run `poetry lock` to reflect the changes in your lock file.
3. Run `make install` again to update the dependencies in your local virtual environment.

For more details on poetry usage https://python-poetry.org/