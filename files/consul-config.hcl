max_stale = "10m"
retry     = "10s"
wait      = "5s:10s"

template {
  source = "/etc/haproxy/haproxy.template"
  destination = "/etc/haproxy/haproxy.cfg"
  command = "/haproxy.sh"
  perms = 0600
}