#!/bin/bash
set -e

chia init -c /root/.ca
mkdir -p /root/.chia/${CHAIN}/config
cp /root/.chia-config/${CHAIN}/config/config.yaml /root/.chia/${CHAIN}/config/config.yaml

if [[ ${TESTNET} == "true" ]]; then
  chia configure --testnet true
fi

case "$@" in
        chia_daemon)
            chia run_daemon
            tail  -f /dev/null
            ;;
        chia_introducer)
            chia start introducer
            tail  -f /dev/null
            ;;
        chia_fullnode)
            chia start node
	    #sleep 120
	    #curl https://chia.keva.app/ | grep -Eo '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' | while read line; do timeout 5s chia show -a $line:8444 ;done
            tail  -f /dev/null
            ;;
        chia_wallet)
	    chia keys add -f /root/.seed/keys.txt
            chia start wallet-only
            tail  -f /dev/null
            ;;
        chia_farmer)
	    chia keys add -f /root/.seed/keys.txt
            chia start farmer-only
            tail  -f /dev/null
            ;;
        chia_harvester)
	    chia keys add -f /root/.seed/keys.txt
            chia start harvester
            tail  -f /dev/null
            ;;
        *)
            exec "$@"
esac
