FROM alpine:3.23

RUN apk add --no-cache python3 py3-pip git && \
    apk add --no-cache docker-cli==27.3.1-r5 --repository https://dl-cdn.alpinelinux.org/v3.21/community/ && \
    git clone -b owner https://github.com/DDS-Derek/runlike.git /runlike && \
    cd /runlike && \
    pip install --upgrade --no-cache-dir --break-system-packages pip && \
    pip install --no-cache-dir --break-system-packages . && \
    apk del --purge git

ENTRYPOINT [ "runlike", "--use-volume-id" ]
