
include_recipe 'jhdc-web::build_essential'

configure_options = node['python']['configure_options'].join(' ')

version = node['python']['version']
pip_version = node['python']['pip_version']

install_path = "#{node['python']['prefix_dir']}" \
               "/lib/python#{version.split(/(^\d+\.\d+)/)[1]}"

remote_file "#{Chef::Config[:file_cache_path]}/Python-#{version}.tar.xz" do
  source "#{node['python']['url']}/#{version}/Python-#{version}.tar.xz"
  checksum node['python']['checksum']
  mode '0644'
  not_if { ::File.exist?(install_path) }
end

bash 'build-and-install-python' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -Jxvf Python-#{version}.tar.xz
  (cd Python-#{version} && ./configure #{configure_options})
  (cd Python-#{version} && make && make install)
  EOF
  not_if { ::File.exist?(install_path) }
end

bash 'upgrade-pip' do
  code <<-EOF
  pip3 install --force --upgrade pip==#{pip_version}
  EOF
  not_if "[[ `pip3 -V` =~ \'pip #{pip_version}\' ]]"
end
