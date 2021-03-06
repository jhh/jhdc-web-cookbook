default['python']['version'] = '3.5.1'
default['python']['pip_version'] = '8.0.2'

default['python']['url'] = 'http://www.python.org/ftp/python'
default['python']['MD5_checksum'] = 'e9ea6f2623fffcdd871b7b19113fde80'

default['python']['prefix_dir'] = '/usr/local'
default['python']['configure_options'] = %W(--prefix=#{python['prefix_dir']})

default['build-essentials']['packages'] = %w(git bzip2 zlib-devel openssl-devel
                                             sqlite-devel bzip2-devel
                                             libffi-devel readline-devel
                                             ncurses-devel expat-devel
                                             gdbm-devel xz-devel
                                             geoip-devel tokyocabinet-devel)

default[:nginx][:letsencrypt] = true
default[:nginx][:repo_config] = '/etc/yum.repos.d/nginx.repo'
default[:nginx][:cert] = 'www.jeffhutchison.com'
default[:nginx][:alt_certs] = ['puka.jeffhutchison.com']
default[:nginx][:root] = '/srv/www'
default[:nginx][:acme_path] = '/.well-known/acme-challenge/'
default[:nginx][:dhparams] = '/etc/nginx/dhparams.pem'

default['letsencrypt']['contact'] = 'mailto:jeff@jeffhutchison.com'
default['letsencrypt']['endpoint'] = 'https://acme-staging.api.letsencrypt.org'

default[:rbenv][:git_repository] = 'git://github.com/sstephenson/rbenv.git'
default[:rbenv][:git_revision] = 'master'
default[:rbenv][:root] = '/home/puka/.rbenv'
default[:ruby_build][:git_repository] = 'git://github.com/sstephenson/' \
                                        'ruby-build.git'
default[:ruby_build][:git_revision] = 'master'

default[:puka][:ruby] = '2.3.0'
default[:puka][:git_repository] = 'git://github.com/jhh/puka-server-sinatra.git'
default[:puka][:git_revision] = 'master'
default[:puka][:fqdn] = 'puka.jeffhutchison.com'
default[:puka][:deploy] = '/srv/puka'
default[:puka][:root] = '/srv/puka-static/current/public'
default[:puka][:ssl] = true

default[:nodejs][:major] = '5'
default[:nodejs][:setup_url] =
  "https://rpm.nodesource.com/setup_#{nodejs[:major]}.x"
default[:nodejs][:repo_config] = '/etc/yum.repos.d/nodesource-el.repo'
default[:nodejs][:repo] = "https://rpm.nodesource.com/pub_#{nodejs[:major]}"

default[:goaccess][:version] = '0.9.8'
default[:goaccess][:url] = 'http://tar.goaccess.io'
