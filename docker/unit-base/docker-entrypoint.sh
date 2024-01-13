#!/bin/sh
# adapted from https://raw.githubusercontent.com/nginx/unit/d48180190752201865f41b2cf1e0a6740fa2ea59/pkg/docker/docker-entrypoint.sh

set -e

WAITLOOPS=5
SLEEPSEC=1

log() {
    echo "$(basename $0): $@"
}

curl_put()
{
    RET=$(/usr/bin/curl -s -w '%{http_code}' -X PUT --data-binary $1 --unix-socket /var/run/control.unit.sock http://localhost/$2)
    RET_BODY=$(echo $RET | /bin/sed '$ s/...$//')
    RET_STATUS=$(echo $RET | /usr/bin/tail -c 4)
    if [ "$RET_STATUS" -ne "200" ]; then
        log "Error: HTTP response status code is '$RET_STATUS'"
        echo "$RET_BODY"
        return 1
    else
        log "OK: HTTP response status code is '$RET_STATUS'"
        echo "$RET_BODY"
    fi
    return 0
}

set_config() {
    for i in $(/usr/bin/seq $WAITLOOPS); do
        if [ ! -S /var/run/control.unit.sock ]; then
            log "Waiting for control socket to be created..."
            /bin/sleep $SLEEPSEC
        else
            break
        fi
    done
    # even when the control socket exists, it does not mean unit has finished initialisation
    # this curl call will get a reply once unit is fully launched
    /usr/bin/curl -s -X GET --unix-socket /var/run/control.unit.sock http://localhost/

    log "Setting access logs to /dev/stdout"
    curl_put '"/dev/stdout"' "config/access_log"

    config="/app/config.json"
    log "Applying configuration $config"
    curl_put @$config config

    echo "$0: Unit configuration complete"
}

if [ "$1" == "set-config" ]; then
    set_config
    exit 0
fi

log "Starting config thread in background..."
sh $0 set-config &

log "Starting unitd..."
exec unitd --control unix:/var/run/control.unit.sock --log /dev/stdout --no-daemon --user unit --group unit
