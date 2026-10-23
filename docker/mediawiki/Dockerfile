ARG MW_VERSION=1.43

# official image: apache + mod_php, rebuilt upstream for php security releases
FROM mediawiki:${MW_VERSION}

ARG MW_VERSION
ARG DPL3_VERSION=3.6.4

RUN docker-php-ext-install exif && a2enmod headers

RUN set -eux; \
    branch="REL$(echo $MW_VERSION | tr . _)"; \
    fetch() { git clone -q --depth 1 --branch "$2" "$3" "$1" && rm -rf "$1/.git"; }; \
    fetch skins/Modern $branch https://gerrit.wikimedia.org/r/mediawiki/skins/Modern; \
    fetch skins/CologneBlue $branch https://gerrit.wikimedia.org/r/mediawiki/skins/CologneBlue; \
    fetch extensions/MobileFrontend $branch https://gerrit.wikimedia.org/r/mediawiki/extensions/MobileFrontend; \
    fetch extensions/Auth_remoteuser $branch https://gerrit.wikimedia.org/r/mediawiki/extensions/Auth_remoteuser; \
    fetch extensions/DynamicPageList3 $DPL3_VERSION https://github.com/Universal-Omega/DynamicPageList4

COPY apache.conf /etc/apache2/conf-enabled/zz-hacklab.conf
COPY php.ini /usr/local/etc/php/conf.d/zz-hacklab.ini

# mount /var/www/html/LocalSettings.php:ro
# mount /var/www/html/images/:rw (owned by www-data, uid 33)
