#!/usr/bin/env bash


set -eu -o pipefail
prototool lint
cd /mnt

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

