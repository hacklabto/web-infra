FROM alpine:latest AS wp2static-builder

RUN apk add composer php82-simplexml php82-dom php82-tokenizer php82-xml php82-xmlwriter zip git
WORKDIR /build
COPY wp2static.patch .
RUN git clone https://github.com/elementor/wp2static
WORKDIR /build/wp2static
RUN git apply ../wp2static.patch
RUN composer install
RUN composer build wp2static

FROM ghcr.io/hacklabto/unit-base:cda4fb84927d8de52c03c98183bf55718699bf0c

RUN wget -O - https://wordpress.org/wordpress-6.4.3.tar.gz | tar xz

# akismet is preinstalled, although maybe we will want to download a specific version of it at some point
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/contact-form-7.5.9.3.zip | busybox unzip -)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/flamingo.2.5.zip | busybox unzip -)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/wp-security-audit-log.zip | busybox unzip -)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/wpdirauth.1.10.7.zip | busybox unzip -)
COPY --from=wp2static-builder /root/Downloads/wp2static.zip /app/wordpress/wp-content/plugins/wp2static.zip
RUN (cd wordpress/wp-content/plugins && busybox unzip wp2static.zip && rm -rf wp2static.zip)
RUN rm wordpress/wp-content/plugins/hello.php

RUN (cd wordpress/wp-content/themes && git clone https://github.com/hacklabto/pixeled-wordpress-theme pixeled && rm -rf pixeled/.git)
RUN (cd wordpress/wp-content/themes && rm -r twentytwentythree twentytwentytwo)

COPY config.json /app/config.json
