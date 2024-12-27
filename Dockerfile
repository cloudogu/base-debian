# keep variables beyond the single build stages, see https://stackoverflow.com/a/53682110/12529534
ARG doguctl_version=0.13.1

FROM debian:12.7-slim AS doguctlbinaryverifier
ARG doguctl_version

ENV DOGUCTL_SHA256=f82f17c6aa64f8d7ac1cc922043823660eb595a2ad45a42b47d10cf86696a85b
ENV DOGUCTL_VERSION=$doguctl_version
RUN mkdir packages
COPY resources/usr/bin/doguctl-$DOGUCTL_VERSION.tar.gz /packages
RUN sha256sum "/packages/doguctl-${DOGUCTL_VERSION}.tar.gz"
RUN set +x && echo "$DOGUCTL_SHA256 */packages/doguctl-${DOGUCTL_VERSION}.tar.gz" | sha256sum -c

FROM debian:12.7-slim
ARG doguctl_version
LABEL maintainer="hello@cloudogu.com"

ENV DOGUCTL_VERSION=${doguctl_version}

COPY resources/ /
# Docker unpacks with ADD the tar.gz arcive directly for us
ADD packages/doguctl-${DOGUCTL_VERSION}.tar.gz /usr/bin/

# install dependencies
RUN apt update && apt -y dist-upgrade && apt install -y --no-install-recommends \
    openssl \
    tar \
    zip \
    unzip \
    ca-certificates \
    jq \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

