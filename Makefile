build:
	docker build -t cobbler .

run:
	docker run \
	  --privileged \
	  --net host \
	  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	  -v $(shell pwd)/etc/cobbler/settings:/etc/cobbler/settings \
	  -v $(shell pwd)/etc/cobbler/dhcp.template:/etc/cobbler/dhcp.template \
	  -p 69:69 \
	  -p 80:80 \
	  -p 443:443 \
	  -p 25151:25151 \
	  --name cobbler cobbler

clean:
	@docker rm cobbler > /dev/null || true

