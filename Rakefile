#
require 'bundler/setup'
require 'kitchen'

def kitchen_instances(regexp, config)
  instances = Kitchen::Config.new(config).instances
  return instances if regexp.nil? || regexp == 'all'
  instances.get_all(Regexp.new(regexp))
end

Kitchen.logger = Kitchen.default_file_logger
config = {
  loader: Kitchen::Loader::YAML.new(local_config: '.kitchen.cloud.yml')
}

namespace :cloud do
  desc 'Create the cloud instance'
  task :create do
    kitchen_instances('default', config).each { |i| i.send('create') }
  end

  desc 'Converge the cloud instance'
  task :converge do
    kitchen_instances('default', config).each { |i| i.send('converge') }
  end
end
