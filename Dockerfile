FROM debian:jessie
MAINTAINER Mihovil Rister <mihovil.rister@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
LABEL "Description"="This is a port of the fake-s3 image that geets the latest changes from https://github.com/jubos/fake-s3.git and supports setting env vars for CORS"
LABEL "fake-s3-repo"="https://github.com/jubos/fake-s3.git"
LABEL "repository"="https://github.com/mrister/fake-s3.git"

# install Ruby
RUN apt-get update && apt-get install -yqq ruby rubygems-integration git

# install fake-s3 from master that has cors support (at the moment unreleased)
RUN gem install specific_install && gem specific_install -l https://github.com/jubos/fake-s3.git

ENV CORS_PREFLIGHT_ALLOW_HEADERS=${CORS_PREFLIGHT_ALLOW_HEADERS:-*}
ENV CORS_ORIGIN=${CORS_ORIGIN:-*}
ENV CORS_METHODS=${CORS_METHODS:-*}
ENV CORS_POST_PUT_ALLOW_HEADERS=${CORS_POST_PUT_ALLOW_HEADERS:-*}
ENV CORS_EXPOSE_HEADERS=${CORS_EXPOSE_HEADERS:-*}
ENV PORT=${PORT:-4569}
# run fake-s3
RUN mkdir -p /fakes3_root

CMD  fakes3 -r /fakes3_root  -p "$PORT" --corspreflightallowheaders "$CORS_PREFLIGHT_ALLOW_HEADERS" --corsorigin "$CORS_ORIGIN" --corsmethods "$CORS_METHODS" --corspostputallowheaders "$CORS_POST_PUT_ALLOW_HEADERS" --corsexposeheaders "$CORS_EXPOSE_HEADERS"

EXPOSE $PORT