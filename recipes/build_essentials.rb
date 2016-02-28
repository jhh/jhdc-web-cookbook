include_recipe 'build-essential::default'
node['build-essentials']['packages'].each do |pkg|
  package pkg
end
