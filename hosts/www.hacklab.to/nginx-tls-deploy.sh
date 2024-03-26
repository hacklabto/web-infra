#!/bin/sh

nginx-tls-deploy_deploy() {
        mv /etc/nginx/tls/hacklab.to{,.old}
        cp -r /root/.acme.sh/hacklab.to_ecc/ /etc/nginx/tls/hacklab.to
        chown -R nginx:nginx /etc/nginx/tls/
        nginx -s reload
}
