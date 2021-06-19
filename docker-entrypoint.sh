#!/bin/bash
set -e

chia init -c /root/.ca

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
            tail  -f /dev/null
            ;;
        chia_wallet)
            chia start wallet-only
            tail  -f /dev/null
            ;;
        chia_farmer)
            chia start farmer-only
            tail  -f /dev/null
            ;;
        chia_harvester)
            chia start harvester
            tail  -f /dev/null
            ;;
        *)
            exec "$@"
esac
