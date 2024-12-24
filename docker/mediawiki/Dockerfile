FROM ghcr.io/hacklabto/unit-base:cda4fb84927d8de52c03c98183bf55718699bf0c

RUN apk add php82-xml php82-ctype php82-session php82-xmlreader imagemagick rsvg-convert

# todo: this image is _way_ too big

RUN sed -i 's#set -e"#(cd /app/mediawiki && php maintenance/run.php update)\n\n&#' docker-entrypoint.sh

RUN wget -O - https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.0.tar.gz | tar xz && mv mediawiki-1.41.0 mediawiki

COPY fetch.sh /tmp
RUN apk add curl jq

ENV MW_VERSION REL1_41

RUN /tmp/fetch.sh skin Modern
RUN /tmp/fetch.sh skin CologneBlue
RUN /tmp/fetch.sh extension MobileFrontend
RUN /tmp/fetch.sh extension Auth_remoteuser
RUN curl -fsL https://github.com/Universal-Omega/DynamicPageList3/archive/REL1_39.tar.gz \
    | tar xz && mv DynamicPageList3-REL1_39 mediawiki/extensions/DynamicPageList3

COPY config.json /app/config.json

# mount /app/mediawiki/LocalSettings.php:ro
# mount /app/mediawiki/images/:rw

