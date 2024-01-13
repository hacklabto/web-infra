FROM ghcr.io/hacklabto/unit-base:f1708a6ec77445ecde3e4c363645df7c03dc241b

RUN apk add php82-xml php82-ctype

# todo: this image is _way_ too big

RUN sed -i 's#set -e"#(cd /app/mediawiki && php maintenance/run.php update)\n\n&#' docker-entrypoint.sh

RUN wget -O - https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.0.tar.gz | tar xz && mv mediawiki-1.41.0 mediawiki

# todo: these links contain a git commit id and will fail to download if the latest commit changed

RUN (cd mediawiki/skins && wget -O - https://extdist.wmflabs.org/dist/skins/Modern-REL1_41-fcf8856.tar.gz | tar xz)
RUN (cd mediawiki/skins && wget -O - https://extdist.wmflabs.org/dist/skins/CologneBlue-REL1_41-b4b4c96.tar.gz | tar xz)
RUN (cd mediawiki/extensions && wget -O - https://extdist.wmflabs.org/dist/extensions/MobileFrontend-REL1_41-2cd7976.tar.gz | tar xz)
RUN (cd mediawiki/extensions && wget -O - https://extdist.wmflabs.org/dist/extensions/Auth_remoteuser-REL1_41-cf8b45e.tar.gz | tar xz)
RUN (cd mediawiki/extensions && wget -O - https://github.com/Universal-Omega/DynamicPageList3/archive/REL1_39.tar.gz | tar xz && mv DynamicPageList3-REL1_39 DynamicPageList3)

COPY config.json /app/config.json

# mount /app/mediawiki/LocalSettings.php:ro
# mount /app/mediawiki/images/:rw
