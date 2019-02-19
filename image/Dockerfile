FROM arm64v8/debian:stretch-slim
MAINTAINER Alfredo Foltran <alfoltran@gmail.com>

COPY . /container
RUN /container/build.sh

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

ENTRYPOINT ["/container/tool/run"]
