FROM ghcr.io/hacklabto/unit-base:49dacf65d2802f8c6c4e67e7e75bbcedb618d803

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
RUN mkdir mediawiki/extensions/DynamicPageList3 && curl -fsL https://github.com/Universal-Omega/DynamicPageList4/archive/REL1_39.tar.gz \
    | tar xz -C mediawiki/extensions/DynamicPageList3 --strip-components=1

COPY config.json /app/config.json

# mount /app/mediawiki/LocalSettings.php:ro
# mount /app/mediawiki/images/:rw

