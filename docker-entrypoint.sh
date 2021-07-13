#!/bin/bash
set -e

chia init -c /root/.ca

case "$@" in
        chia_daemon)
            chia run_daemon
            tail  -f /dev/null
            ;;
        chia_introducer)
	    cp /root/.chia-config/${CHAIN}/config/config.yaml /root/.chia/${CHAIN}/config/config.yaml
            chia start introducer
            tail  -f /dev/null
            ;;
        chia_fullnode)
	    cp /root/.chia-config/${CHAIN}/config/config.yaml /root/.chia/${CHAIN}/config/config.yaml
            chia start node
	    #sleep 120
	    #curl https://chia.keva.app/ | grep -Eo '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' | while read line; do timeout 5s chia show -a $line:8444 ;done
            tail  -f /dev/null
            ;;
        chia_wallet)
	    cp /root/.chia-config/${CHAIN}/config/config.yaml /root/.chia/${CHAIN}/config/config.yaml
	    chia keys add -f /root/.seed/keys.txt
            chia start wallet-only
            tail  -f /dev/null
            ;;
        chia_farmer)
	    cp /root/.chia-config/${CHAIN}/config/config.yaml /root/.chia/${CHAIN}/config/config.yaml
	    chia keys add -f /root/.seed/keys.txt
            chia start farmer-only
            tail  -f /dev/null
            ;;
        chia_harvester)
	    cp /root/.chia-config/mainnet/config/config.yaml /root/.chia/mainnet/config/config.yaml
	    chia keys add -f /root/.seed/keys.txt
            chia start harvester
            tail  -f /dev/null
            ;;
        *)
            exec "$@"
esac
