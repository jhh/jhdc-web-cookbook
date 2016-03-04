source 'https://rubygems.org'

gem 'berkshelf', '~> 4.2'

group :development do
  gem 'pry'
end

group :test do
  gem 'rake'
end

group :integration do
  gem 'test-kitchen', '~> 1.6'
  gem 'kitchen-vagrant', '~> 0.19'
end

group :integration_cloud do
  gem 'kitchen-digitalocean', '~> 0.8'
  gem 'kitchen-sync'
end
