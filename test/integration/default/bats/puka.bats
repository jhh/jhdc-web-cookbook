# unset busser environment
unset GEM_HOME
unset GEM_PATH
unset GEM_CACHE

# enable rbenv
export PATH="/home/puka/.rbenv/bin:/home/puka/.rbenv/plugins/ruby-build/bin:$PATH"
export RBENV_ROOT="/home/puka/.rbenv"
eval "$(rbenv init -)"

@test "puka tests pass" {
  run ruby -v
  [ "$status" -eq 0 ]
}
