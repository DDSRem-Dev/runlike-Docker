FROM alpine:3.21

RUN apk add --no-cache docker-cli python3 py3-pip git && \
    git clone -b owner https://github.com/DDS-Derek/runlike.git /runlike && \
    cd /runlike && \
    pip install --upgrade --no-cache-dir --break-system-packages pip && \
    pip install --no-cache-dir --break-system-packages . && \
    apk del --purge git

ENTRYPOINT [ "runlike", "--use-volume-id" ]
