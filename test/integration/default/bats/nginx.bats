@test "nginx service is running" {
  run systemctl status nginx.service
  [ "$status" -eq 0 ]
}

@test "http was added to firewall" {
        run firewall-cmd --permanent --query-service=http
        [ "$status" -eq 0 ]
}

@test "https was added to firewall" {
        run firewall-cmd --permanent --query-service=https
        [ "$status" -eq 0 ]
}
