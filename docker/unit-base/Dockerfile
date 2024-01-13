FROM alpine:latest

RUN apk add unit-php82 php82-ldap php82-mysqli php82-curl php82-dom php82-exif php82-fileinfo \
    php82-pecl-imagick php82-mbstring php82-zip php82-gd php82-iconv php82-intl \
    zip curl git strace

WORKDIR /app

COPY docker-entrypoint.sh .

VOLUME [ "/var/lib/unit" ]
VOLUME [ "/run" ]
VOLUME [ "/tmp" ]

CMD [ "/app/docker-entrypoint.sh" ]
