
.PHONY: protos

all:
	docker build - < ci/Dockerfile -t protobuilder
	docker run  -v `pwd`:/mnt protobuilder /mnt/ci/compile_protos.sh

update:
	echo "Running post merge job: Push to fabric-protos-go"
	docker build - < ci/Dockerfile -t protobuilder
	docker run  -v `pwd`:/mnt protobuilder /mnt/ci/update_protos.sh
	set -x
	cd build/fabric-protos-go
	git status | grep ".pb.go$" | awk '{print $NF}' | xargs git add
	git config user.name "fabric-gdpr"
	git config user.email "<>"
	git commit -F COMMIT
	git remote add upstream git@github.com:FabricGDPR/fabric-protos-go.git
	git push origin test
