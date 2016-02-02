

node['python']['dev_packages'].each do |pkg|
  package pkg
end

configure_options = node['python']['configure_options'].join(" ")

version = node['python']['version']
install_path = "#{node['python']['prefix_dir']}/lib/python#{version.split(/(^\d+\.\d+)/)[1]}"

remote_file "#{Chef::Config[:file_cache_path]}/Python-#{version}.tar.xz" do
  source "#{node['python']['url']}/#{version}/Python-#{version}.tar.xz"
  checksum node['python']['checksum']
  mode "0644"
  not_if { ::File.exists?(install_path) }
end

bash "build-and-install-python" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -Jxvf Python-#{version}.tar.xz
  (cd Python-#{version} && ./configure #{configure_options})
  (cd Python-#{version} && make && make install)
  EOF
  not_if { ::File.exists?(install_path) }
end
