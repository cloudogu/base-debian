ARG DEBIAN_VERSION
ARG DEBIAN_VER_SHA

FROM debian:${DEBIAN_VERSION}@sha256:${DEBIAN_VER_SHA} AS base

LABEL maintainer="hello@cloudogu.com"

COPY resources/ /

COPY packages/doguctl.tar.gz /tmp/doguctl.tar.gz
RUN tar -xzf /tmp/doguctl.tar.gz -C /tmp \
    && install -m 755 -p /tmp/doguctl /usr/local/bin/doguctl \
    && rm -f /tmp/doguctl.tar.gz /tmp/doguctl

# install utilities and dependencies
RUN apt update \
  && apt -y dist-upgrade \
  && apt install -y --no-install-recommends \
    bash \
    ca-certificates \
    jq \
    openssl \
    tar \
    zip unzip \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*
