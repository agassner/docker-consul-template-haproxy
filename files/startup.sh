#!/bin/bash
./haproxy.sh
consul-template -consul=${CONSUL_ADDRESS} -config=/consul-config.hcl