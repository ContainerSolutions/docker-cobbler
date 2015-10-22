build:
	@docker build -t cobbler .

run:
	@docker run \
	  -d \
	  --privileged \
	  --net host \
	  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	  -v $(shell pwd)/etc/cobbler/settings:/etc/cobbler/settings \
	  -v $(shell pwd)/etc/cobbler/dhcp.template:/etc/cobbler/dhcp.template \
	  -v $(shell pwd)/dist/centos:/mnt:ro \
	  -p 69:69 \
	  -p 80:80 \
	  -p 443:443 \
	  -p 25151:25151 \
	  --name cobbler cobbler

clean:
	@docker rm cobbler > /dev/null || true

mount:
	sudo mount -t iso9660 -o loop,ro -v $(shell pwd)/dist/centos.iso dist/centos

tty:
	@docker exec -it cobbler /bin/bash

stop:
	@docker stop cobbler

start:
	@docker start cobbler

import:
	@docker exec -it cobbler cobbler import --name=centos7 --arch=x86_64 --path=/mnt

all: build mount run import
