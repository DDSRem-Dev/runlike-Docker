FROM alpine:3.23

ARG TARGETPLATFORM
ARG DOCKER_CLI_VERSION=20.10.24

ENV DOCKER_API_VERSION=1.41

RUN apk add --no-cache python3 py3-pip git curl && \
    case "${TARGETPLATFORM}" in \
        "linux/amd64")    ARCH="x86_64"  ;; \
        "linux/arm64"*)   ARCH="aarch64" ;; \
        "linux/arm/v7")   ARCH="armhf"   ;; \
        "linux/arm/v6")   ARCH="armel"   ;; \
        *)                ARCH="x86_64"  ;; \
    esac && \
    echo "Building for ${TARGETPLATFORM}, downloading for ${ARCH}..." && \
    curl -L "https://download.docker.com/linux/static/stable/${ARCH}/docker-${DOCKER_CLI_VERSION}.tgz" | tar -xz -C /tmp && \
    mv /tmp/docker/docker /usr/bin/docker && \
    rm -rf /tmp/docker && \
    git clone -b owner https://github.com/DDS-Derek/runlike.git /runlike && \
    cd /runlike && \
    pip install --no-cache-dir --break-system-packages . && \
    apk del --purge git curl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT [ "runlike", "--use-volume-id" ]
