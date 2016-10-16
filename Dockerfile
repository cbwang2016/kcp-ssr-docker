FROM cbwang/ssr-docker

ENV KCP_VER 20161009

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
ADD start.sh /start.sh
RUN chmod +x /start.sh
    
ENV KCPTUN_ARGS="-l :8081 -t 127.0.0.1:8080 -crypt none --mtu 1200 --nocomp --mode normal --dscp 46 --parityshard 0"
EXPOSE 8080/tcp 8080/udp 8081/udp
ENTRYPOINT ["/start.sh"]
