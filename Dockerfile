FROM alpine:latest

ENV TIMEZONE Asia/Shanghai

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update \
    && apk upgrade \
    && apk add \
    tzdata \
    mysql \
    mysql-client \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && apk del tzdata \
    && rm -rf /var/cache/apk/*

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

EXPOSE 3306

CMD ["/startup.sh"]