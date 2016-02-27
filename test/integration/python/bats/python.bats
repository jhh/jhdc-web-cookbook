
@test "Python 3 is installed" {
  run /usr/local/bin/python3 -V
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Python 3" ]]
}

@test "Pip 8 is installed" {
  run /usr/local/bin/pip3 -V
  [ "$status" -eq 0 ]
  [[ "$output" =~ "pip 8" ]]
}
