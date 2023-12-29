FROM alpine:latest

RUN apk add unit-php82 php82-ldap php82-mysqli zip curl git

WORKDIR /app

# Unit entrypoint, but config is in /app/config instead of /docker-entrypoint.d
RUN wget https://raw.githubusercontent.com/nginx/unit/d48180190752201865f41b2cf1e0a6740fa2ea59/pkg/docker/docker-entrypoint.sh
RUN sed -i 's/docker-entrypoint\.d/app\/config/g' docker-entrypoint.sh
RUN sed -i 's#exec "$@"#mount -t tmpfs none /var/lib/unit\n&#' docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

RUN wget -O - https://wordpress.org/wordpress-6.4.2.tar.gz | tar xz

# akismet is preinstalled, although maybe we will want to download a specific version of it at some point
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/contact-form-7.5.8.5.zip | unzip)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/flamingo.2.4.zip | unzip)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/wp-security-audit-log.zip | unzip)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/wpdirauth.1.10.7.zip | unzip)

RUN (cd wordpress/wp-content/themes && git clone https://github.com/hacklabto/pixeled-wordpress-theme pixeled && rm -rf pixeled/.git)

WORKDIR /app/config
COPY config.json .

# mount /app/wordpress/wp-config.php:ro
# mount /app/wordpress/wp-content/uploads/:rw

CMD [ "/app/docker-entrypoint.sh", "unitd", "--no-daemon", "--user", "nobody", "--group", "nobody" ]