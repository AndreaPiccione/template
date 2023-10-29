FROM python:3.11-slim AS builder
ENV PYTHONUNBUFFERED=1

RUN apt-get -y update && apt-get -y upgrade && apt-get --no-install-recommends -y install git ssh
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install -U pip poetry

# Authentication
RUN mkdir /root/.ssh
COPY id_rsa /root/.ssh/id_rsa
RUN \
  touch /root/.ssh/knowh_hosts && \
  git config --global url."git@github.com:".insteadOf "https://github.com/"

# Core dependencies
COPY poetry.lock pyproject.toml /
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi --no-root && rm -f /root/.ssh/id_rsa

FROM python:3.11-slim
ENV PYTHONUNBUFFERED=1
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY . /
RUN pip install --no-deps -e .
RUN useradd -rs /bin/bash runner
USER runner

# CMD ["./start.sh"]