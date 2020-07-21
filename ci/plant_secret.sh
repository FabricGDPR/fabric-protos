#!/usr/bin/env bash

set -eu -o pipefail

echo "Planting ssh private key in filesystem"

echo "${MY_SECRET}" | while read s; do
    echo ${s} > ci/id_rsa
done
