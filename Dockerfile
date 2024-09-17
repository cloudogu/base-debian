# keep variables beyond the single build stages, see https://stackoverflow.com/a/53682110/12529534
ARG doguctl_version=0.12.2

FROM debian:12.7-slim as doguctlBinaryVerifier
ARG doguctl_version

ENV DOGUCTL_SHA256=ac4b56f17a8b86ae398b45f33ba0c11bf4e2b80030d915d5b89207582f3ff648
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
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

