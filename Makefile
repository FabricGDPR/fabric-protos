
.PHONY: protos

all:
	docker build - < ci/Dockerfile -t protobuilder
	docker run  -v `pwd`:/mnt protobuilder /mnt/ci/compile_protos.sh

update:
	echo "Running post merge job: Push to fabric-protos-go"
	docker build - < ci/Dockerfile -t protobuilder
	docker run  -v `pwd`:/mnt protobuilder /mnt/ci/update_protos.sh
	/mnt/ci/push_protos.sh
