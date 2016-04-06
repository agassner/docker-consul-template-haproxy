#!/bin/bash

haproxy -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid -D

consul-template \
	-consul=${CONSUL_ADDRESS} \
	-config=/consul-config.hcl \
	-log-level debug
