
package 'nginx' do
  action :upgrade
end

service 'nginx' do
  # supports status: true, restart: true, reload: true
  action [:enable, :start]
end

include_recipe 'firewalld::default'
firewalld_service "http"
firewalld_service "https"
