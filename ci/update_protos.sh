#!/usr/bin/env bash


set -eu -o pipefail
prototool lint
cd /mnt

echo "Configuring github credentials"

git config user.name "fabric-gdpr"
git config user.email "<>"

echo SECRET ${SECRET}
echo DUMMY ${DUMMY}
echo DUMMY2 ${DUMMY}

[ -d ~/.ssh ] || mkdir ~/.ssh
echo ${SECRET} | sed "s/@/\n/g" | base64 --decode > ~/.ssh/id_rsa
chmod 700 .ssh
chmod 600 .ssh/id_rsa

git clone git@github.com:FabricGDPR/fabric-protos-go.git build/fabric-protos-go
/mnt/ci/cleanup.sh build/fabric-protos-go
/mnt/ci/compile_go_protos.sh
cd /mnt/build/fabric-protos-go
go mod tidy
go build ./...
git diff --color

echo "Pushing code to [github.com/FabricGDPR/fabric-protos-go]"
git status | grep ".pb.go$" | awk '{print $NF}' | xargs git add
git commit -m "test"

git push origin test