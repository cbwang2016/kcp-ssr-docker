FROM cbwang/ssr-docker

ENV KCP_VER 20160922

RUN \
    apk add --no-cache --virtual .build-deps curl \
    && mkdir -p /opt/kcptun \
    && cd /opt/kcptun \
    && curl -fSL https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-amd64-$KCP_VER.tar.gz | tar xz \
    && rm client_linux_amd64 \
    && cd ~ \
    && apk del .build-deps \
    && apk add --no-cache supervisor
    
COPY supervisord.conf /etc/supervisord.conf
    
ENV KCPTUN_ARGS="-l :3 -t 127.0.0.1:1 -crypt none --mtu 1200 --nocomp --mode fast --dscp 46 --parityshard 0"
ENTRYPOINT ["/usr/bin/supervisord"]
