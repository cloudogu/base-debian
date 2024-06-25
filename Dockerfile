# keep variables beyond the single build stages, see https://stackoverflow.com/a/53682110/12529534
ARG doguctl_version=0.11.0

FROM debian:12.5-slim as doguctlBinaryVerifier
ARG doguctl_version

ENV DOGUCTL_SHA256=2b49d960e8d5abcb72fe5c621fd1ff9d248421d0bc0b58f4751e67125ecc64e0
ENV DOGUCTL_VERSION=$doguctl_version
RUN mkdir packages
COPY resources/usr/bin/doguctl-$DOGUCTL_VERSION.tar.gz /packages
RUN sha256sum "/packages/doguctl-${DOGUCTL_VERSION}.tar.gz"
RUN set +x && echo "$DOGUCTL_SHA256 */packages/doguctl-${DOGUCTL_VERSION}.tar.gz" | sha256sum -c

FROM debian:12.5-slim
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
