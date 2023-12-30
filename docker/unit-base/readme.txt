Base Docker image for PHP service under NGINX Unit

Features:
- Supports running under read-only rootfs in container.
- Applies config from /app/config.json

Bugs:
- tmpfs volumes required for Unit are not cleaned up automatically (run `docker volume prune` once in a while)
