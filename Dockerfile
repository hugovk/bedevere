FROM python:3.11-slim

ENV PIP_NO_CACHE_DIR 1
ENV PIP_ROOT_USER_ACTION ignore
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get -qq update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install time \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
COPY dev-requirements.txt dev-requirements.txt


COPY entrypoint.sh /entrypoint.sh
COPY bedevere/ /bedevere/

RUN time pip install --no-cache-dir --prefer-binary -r requirements.txt

ENTRYPOINT ["/entrypoint.sh"]
