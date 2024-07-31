REPO := template

install:
		pip install -U pip poetry -q
		poetry install --with=dev,test --all-extras
		poetry run pre-commit install
		poetry run pre-commit autoupdate

build_image:
		docker build -t $(REPO) .

push_image:
		aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin {aws_address}
		docker tag $(REPO):latest {aws_address}/$(REPO):latest
		docker push {aws_address}/$(REPO):latest

docker_run:
		docker run -p 80:80 -i -e SOMEVAR=someval $(REPO)

precommit:
		poetry run pre-commit run --all-files

test:
		poetry run pytest

tests: test

all: precommit tests

image: build_image push_image

docker: build_image docker_run