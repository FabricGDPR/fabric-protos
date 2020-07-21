#!/usr/bin/env bash

set -eux -o pipefail

echo "Planting ssh private key in filesystem"

echo "${MY_SECRET}" | while read s; do
    echo ${s} > id_rsa
done


cat id_rsa