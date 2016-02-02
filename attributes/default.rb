default['python']['url'] = 'http://www.python.org/ftp/python'
default['python']['version'] = '3.5.1'
default['python']['MD5_checksum'] = 'e9ea6f2623fffcdd871b7b19113fde80'
default['python']['prefix_dir'] = '/usr/local'

default['python']['configure_options'] = %W{--prefix=#{python['prefix_dir']}}

default['python']['dev_packages'] =
   %w{zlib-devel openssl-devel sqlite-devel bzip2-devel libffi-devel
      readline-devel ncurses-devel expat-devel db4-devel gdbm-devel
      xz-devel gcc}
