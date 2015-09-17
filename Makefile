build:
	docker build -t cobbler .

run:
	docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -p 25151:25151 --name cobbler cobbler
