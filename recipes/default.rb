# order matters - nginx depends on group 'web' created in puka
include_recipe 'jhdc-web::puka'
include_recipe 'jhdc-web::nginx'
include_recipe 'jhdc-web::mongodb'
