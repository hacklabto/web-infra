MediaWiki image for knowledge.hacklab.to and wiki.hacklab.to

Official mediawiki image (apache + mod_php) plus the skins/extensions we use:
Modern, CologneBlue, MobileFrontend, Auth_remoteuser, DynamicPageList3.
apache.conf and php.ini are hardening on top of upstream defaults.

Mounts:
- /var/www/html/LocalSettings.php (read-only)
- /var/www/html/images/ (read-write, owned by www-data, uid 33)

Security patches:
- CI rebuilds weekly against the current upstream image and pushes :latest
  (main only) plus :<commit sha>.
- With MEDIAWIKI_COMMIT=latest: docker compose pull knowledge wiki && docker compose up -d knowledge wiki

Upgrading MediaWiki:
1. Bump MW_VERSION in the Dockerfile (extension branches follow it). Check
   DPL3_VERSION supports the new version.
2. Back up both databases.
3. Deploy the new image, then for each wiki:
   docker compose run --rm knowledge php maintenance/run.php update --quick
   docker compose run --rm wiki php maintenance/run.php update --quick

One-time migration from the old NGINX Unit image (MediaWiki 1.41):
1. Back up both databases, /opt/{knowledge,wiki}/images and LocalSettings.php.
2. In each LocalSettings.php, change any /app/mediawiki paths to /var/www/html.
3. chown -R 33:33 /opt/knowledge/images /opt/wiki/images
4. Set MEDIAWIKI_COMMIT, docker compose pull knowledge wiki
5. Run update.php for each wiki (as above), then
   docker compose up -d --force-recreate --renew-anon-volumes knowledge wiki
6. Check Special:Version on both, and that logging in to wiki.hacklab.to
   still works (Auth_remoteuser behind lighttpd basic auth).
