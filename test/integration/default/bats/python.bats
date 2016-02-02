@test "Python 3 is installed" {
  run /usr/local/bin/python3 -V
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Python 3" ]]
}
