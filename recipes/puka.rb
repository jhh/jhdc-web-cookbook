
include_recipe 'jhdc-web::build_essentials'

users_manage 'web' do
  group_id 3000
  action [:create]
  data_bag 'web'
end

rbenv_root = node[:rbenv][:root]

git rbenv_root do
  repository node[:rbenv][:git_repository]
  revision node[:rbenv][:git_revision]
  user 'puka'
end

directory "#{rbenv_root}/plugins" do
  action :create
  user 'puka'
end

git "#{rbenv_root}/plugins/ruby-build" do
  repository node[:ruby_build][:git_repository]
  revision node[:ruby_build][:git_revision]
  user 'puka'
end

file '/home/puka/.bash_profile' do
  content <<-EOT
  if [ -f ~/.bashrc ]; then
  	. ~/.bashrc
  fi
  export PATH="#{rbenv_root}/bin:#{rbenv_root}/plugins/ruby-build/bin:$PATH"
  eval "$(rbenv init -)"
  EOT
  user 'puka'
end

file '/home/puka/.gemrc' do
  content(<<-EOF)
    gem: --no-document
  EOF
  user 'puka'
end

ruby_version = node[:puka][:ruby]
install_path = "#{rbenv_root}/versions/#{ruby_version}"
rbenv_env = { 'HOME' => '/home/puka',
              'PATH' => "#{rbenv_root}/bin:" \
                        "#{rbenv_root}/plugins/ruby-build/bin:" \
                        "#{ENV['PATH']}",
              'RBENV_ROOT' => rbenv_root }

bash install_path do
  user 'puka'
  environment rbenv_env
  code <<-EOC
  eval "$(rbenv init -)"
  rbenv install #{ruby_version}
  rbenv global #{ruby_version}
  gem install bundler
  EOC
  not_if { ::File.exist? "#{install_path}/bin/ruby" }
end

puka_root = node[:puka][:root]

directory puka_root do
  owner 'puka'
  mode '2775'
  action :create
end

git puka_root do
  repository node[:puka][:git_repository]
  revision node[:puka][:git_revision]
  user 'puka'
end

bash "bundle #{puka_root}" do
  user 'puka'
  environment rbenv_env
  code <<-EOC
  cd #{puka_root}
  eval "$(rbenv init -)"
  bundle install --deployment --without development --binstubs
  EOC
  not_if "cd #{puka_root} && #{rbenv_root}/shims/bundle check",
         user: 'puka', environment: rbenv_env
end
