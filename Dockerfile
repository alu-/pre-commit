FROM python:${python_version:-3.8}-${image_variant:-alpine}

MAINTAINER alu@byteberry.net

RUN apk add --no-cache git build-base gcc musl-dev

ADD . /pre-commit-src/

RUN cd /pre-commit-src && \
    python setup.py install && \
    rm -rf /pre-commit-src && \
    mkdir /src && \
    git config --global --add safe.directory '*'

WORKDIR /src

ENTRYPOINT ["pre-commit"]
CMD ["run"]
