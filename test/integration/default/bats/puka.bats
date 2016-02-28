# unset busser environment
unset GEM_HOME
unset GEM_PATH
unset GEM_CACHE

# enable rbenv
export PATH="/home/puka/.rbenv/bin:/home/puka/.rbenv/plugins/ruby-build/bin:$PATH"
export RBENV_ROOT="/home/puka/.rbenv"
eval "$(rbenv init -)"

export PUKA_ROOT="/srv/puka"
export RAKE="bundle exec rake"

setup() {
  cd $PUKA_ROOT
  $RAKE 'test:db' >&2
}

@test "puka tests pass" {
  cd $PUKA_ROOT
  run $RAKE test
  [ "$status" -eq 0 ]
}

teardown() {
  mongo "test" --eval "db.bookmarks.drop()"
}
