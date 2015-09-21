build:
	docker build -t cobbler .

run:
	docker run \
	  --privileged \
	  --net host \
	  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	  -v $(shell pwd)/etc/cobbler/settings:/etc/cobbler/settings \
	  -v $(shell pwd)/etc/cobbler/dhcp.template:/etc/cobbler/dhcp.template \
    -v $(shell pwd)/dist/centos:/mnt:ro \
    -v $(shell pwd)/ks_mirror:/var/www/cobbler/ks_mirror \
	  -p 69:69 \
	  -p 80:80 \
	  -p 443:443 \
	  -p 25151:25151 \
	  --name cobbler cobbler

clean:
	@docker rm cobbler > /dev/null || true

mount:
	mount -t iso9660 -o loop,ro -v $(shell pwd)/dist/centos.iso dist/centos
