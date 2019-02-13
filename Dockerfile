FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -q -y git \
    zip \
    jq &&\
    rm -rf /var/lib/apt/lists/*

COPY run.sh meta.json /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]
