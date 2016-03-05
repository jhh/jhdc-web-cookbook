ver = node[:nodejs][:major]
repo_config = node[:nodejs][:repo_config]

execute 'install node repository' do
  command <<-EOC
  rm -f #{repo_config}
  curl --silent --location #{node[:nodejs][:setup_url]} | bash -
  EOC
  not_if "grep '#{node[:nodejs][:repo]}' #{repo_config}"
end

package 'nodejs' do
  action :upgrade
end
