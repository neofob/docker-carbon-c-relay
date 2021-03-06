#!/bin/sh


GRAPHITE_HOST=${GRAPHITE_HOST:-graphite}
GRAPHITE_PORT=${GRAPHITE_PORT:-2003}

cfgFile="/etc/carbon-c-relay.conf"

createConfig() {

  sed -i \
    -e "s/%GRAPHITE_HOST%/${GRAPHITE_HOST}/" \
    -e "s/%GRAPHITE_PORT%/${GRAPHITE_PORT}/" \
    ${cfgFile}

}

run() {

  createConfig

  /bin/relay -f ${cfgFile} -t < /dev/null > /dev/null

  /bin/relay -f ${cfgFile} -w 4 -q 2056 -m -b 2056 -l /var/log/carbon-relay.log
}

run

# EOF
