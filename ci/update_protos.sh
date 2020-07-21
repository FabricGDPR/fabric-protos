#!/usr/bin/env bash

set -eu -o pipefail
prototool lint
cd /mnt
git clone https://github.com/FabricGDPR/fabric-protos-go.git build/fabric-protos-go
/mnt/ci/cleanup.sh build/fabric-protos-go
/mnt/ci/compile_go_protos.sh
cd /mnt/build/fabric-protos-go
go mod tidy
go build ./...
git diff --color

echo "Pushing code to [github.com/FabricGDPR/fabric-protos-go]"
git status | grep ".pb.go$" | awk '{print $NF}' | sudo  xargs git add
git commit -s -m "test"

git config --global user.name "Fabric GDPR"
git config --global user.email '<>'

[ -d ~/.ssh ] || mkdir ~/.ssh
echo ${GITHUB_PASSWORD} | sed "s/ /\n/g" | base64 --decode > ~/.ssh/id_rsa

git push origin test