
include_recipe 'jhdc-web::build_essentials'

archive = "goaccess-#{node[:goaccess][:version]}.tar.gz"

remote_file "/tmp/#{archive}" do
  source "#{node[:goaccess][:url]}/#{archive}"
end

bash 'build goaccess' do
  code <<-EOC
  cd /tmp
  tar -xzf #{archive}
  cd goaccess-#{node[:goaccess][:version]}
  ./configure --enable-geoip --enable-tcb=btree
  make
  make install
  EOC
  not_if "[[ `goaccess -V` =~ \'#{node[:goaccess][:version]}\' ]]"
end

cookbook_file '/usr/local/etc/goaccess.conf' do
  source 'goaccess.conf'
end
