#!/usr/bin/env bash

set -eux -o pipefail

cp -r /ssh ~/.ssh
chmod 700 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa

cd build/fabric-protos-go
git status | grep .pb.go | awk '{print $NF}' | xargs git add
git config user.name "fabric-gdpr"
git config user.email "<>"
git commit -F .COMMIT
git remote add upstream git@github.com:FabricGDPR/fabric-protos-go.git
git push upstream master