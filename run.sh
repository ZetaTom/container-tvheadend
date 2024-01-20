#!/bin/bash
podman volume create tvheadend-config
podman volume create tvheadend-recordings

podman run \
	--detach \
	--name tvheadend \
	--restart on-failure \
	--label "io.containers.autoupdate=local" \
	--group-add keep-groups \
	--network "slirp4netns:outbound_addr=wg1,enable_ipv6=false" \
	--dns 1.1.1.1 \
	--publish 9981:9981 \
	--publish 9982:9982 \
	--volume tvheadend-config:/config:Z \
	--volume tvheadend-recordings:/recordings:Z \
	--device /dev/dri/renderD128 \
	--device /dev/dvb \
	--env TZ=Europe/Berlin \
	localhost/tvheadend:latest
