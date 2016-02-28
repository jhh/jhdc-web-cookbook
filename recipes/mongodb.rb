
cookbook_file '/etc/yum.repos.d/mongodb-org-3.2.repo' do
  source 'mongodb.repo'
end

package 'mongodb-org' do
  action :upgrade
end

service 'mongod' do
  action [:enable, :start]
end
