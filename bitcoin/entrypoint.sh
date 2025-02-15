#!/bin/bash

if [ ! -d /data/bitcoin ]; then
    echo "Make sure data directory exits already for this to work"
    exit 1
fi

echo "Running cmd: $@"
"$@"