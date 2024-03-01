FROM ghcr.io/hacklabto/unit-base:cda4fb84927d8de52c03c98183bf55718699bf0c

RUN wget -O - https://wordpress.org/wordpress-6.4.3.tar.gz | tar xz

# akismet is preinstalled, although maybe we will want to download a specific version of it at some point
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/contact-form-7.5.8.7.zip | busybox unzip -)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/flamingo.2.4.zip | busybox unzip -)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/wp-security-audit-log.zip | busybox unzip -)
RUN (cd wordpress/wp-content/plugins && wget -O - https://downloads.wordpress.org/plugin/wpdirauth.1.10.7.zip | busybox unzip -)
RUN rm wordpress/wp-content/plugins/hello.php

RUN (cd wordpress/wp-content/themes && git clone https://github.com/hacklabto/pixeled-wordpress-theme pixeled && rm -rf pixeled/.git)
RUN (cd wordpress/wp-content/themes && rm -r twentytwentythree twentytwentytwo)

COPY config.json /app/config.json
