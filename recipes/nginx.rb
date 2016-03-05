# Generate selfsigned certificate so nginx can start
letsencrypt_selfsigned node[:nginx][:cert] do
  crt "/etc/ssl/#{node[:nginx][:cert]}.crt"
  key "/etc/ssl/#{node[:nginx][:cert]}.key"
end

template node[:nginx][:repo_config] do
  source 'nginx.repo.erb'
  variables osrelease: node['platform_version'].split('.').first
end

package 'nginx' do
  action :upgrade
  options '--disablerepo=* --enablerepo=nginx'
  notifies :restart, 'service[nginx]'
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action :enable
end

include_recipe 'firewalld::default'
firewalld_service 'http'
firewalld_service 'https'

execute 'dhparams' do
  command "openssl dhparam -out #{node[:nginx][:dhparams]} 2048"
  not_if { FileTest.file?(node[:nginx][:dhparams]) }
end

template '/etc/nginx/conf.d/puka.conf' do
  source 'nginx-puka.conf.erb'
  notifies :restart, 'service[nginx]'
end

template '/etc/nginx/conf.d/www.conf' do
  source 'nginx-www.conf.erb'
  notifies :restart, 'service[nginx]'
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  notifies :restart, 'service[nginx]', :immediate
end

directory node[:nginx][:root] do
  action :create
  group 'web'
  only_if 'getent group web' # enables .kitchen.yml nginx suite to run
end

%w(index.html robots.txt).each do |file|
  cookbook_file "#{node[:nginx][:root]}/#{file}" do
    source file
    only_if { FileTest.directory?(node[:nginx][:root]) }
  end
end

if node[:nginx][:letsencrypt]
  include_recipe 'letsencrypt'

  letsencrypt_certificate node[:nginx][:cert] do
    alt_names node[:nginx][:alt_certs]
    fullchain "/etc/ssl/#{node[:nginx][:cert]}.crt"
    chain     "/etc/ssl/#{node[:nginx][:cert]}-chain.crt"
    key       "/etc/ssl/#{node[:nginx][:cert]}.key"
    method    'http'
    wwwroot   node[:nginx][:root]
    notifies  :reload, 'service[nginx]'
  end
end
