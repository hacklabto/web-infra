#!/bin/sh

nginx-tls-deploy.sh_deploy() {
	cp -r /root/.acme.sh/hacklab.to_ecc/ /etc/nginx/tls/hacklab.to/
	chown -R nginx:nginx /etc/nginx/tls/
	nginx -s reload
}
