#!/usr/bin/env bash

set -eu -o pipefail

echo "Planting ssh private key in filesystem"

echo ${MY_SECRET} | sed "s/@/\n/g" | base64 --decode > id_rsa
