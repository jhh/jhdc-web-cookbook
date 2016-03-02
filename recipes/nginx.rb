include_recipe 'yum-epel'

package 'nginx' do
  action :upgrade
  notifies :restart, 'service[nginx]'
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action :enable
end

include_recipe 'firewalld::default'
firewalld_service 'http'
firewalld_service 'https'

template '/etc/nginx/conf.d/puka.conf' do
  source 'nginx-puka.conf.erb'
  notifies :restart, 'service[nginx]'
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  notifies :restart, 'service[nginx]'
end
