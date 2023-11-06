# keep variables beyond the single build stages, see https://stackoverflow.com/a/53682110/12529534
ARG doguctl_version=0.7.0

FROM debian:12.2-slim as doguctlBinaryVerifier
ARG doguctl_version

ENV DOGUCTL_SHA256=4c38d308c2fe3f8eb2b44c075af7038c2d0dc1c4a5dfcd5d75393de2d1f06c0c
ENV DOGUCTL_VERSION=$doguctl_version
RUN mkdir packages
COPY resources/usr/bin/doguctl-$DOGUCTL_VERSION.tar.gz /packages
RUN sha256sum "/packages/doguctl-${DOGUCTL_VERSION}.tar.gz"
RUN set +x && echo "4c38d308c2fe3f8eb2b44c075af7038c2d0dc1c4a5dfcd5d75393de2d1f06c0c */packages/doguctl-${DOGUCTL_VERSION}.tar.gz" | sha256sum -c

FROM debian:12.2-slim
ARG doguctl_version
LABEL maintainer="hello@cloudogu.com"

ENV DOGUCTL_VERSION=${doguctl_version}

COPY resources/ /

# install dependencies
RUN apt update && apt -y dist-upgrade && apt install -y --no-install-recommends \
    openssl \
    tar \
    zip \
    unzip \
    ca-certificates \
    jq \
    && tar -xvzf /usr/bin/doguctl-${DOGUCTL_VERSION}.tar.gz -C /usr/bin/ \
    && rm /usr/bin/doguctl-${DOGUCTL_VERSION}.tar.gz \
    && apt clean
