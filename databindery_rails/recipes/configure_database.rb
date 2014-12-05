config_dir = "/srv/www/bananaboat/shared/config"

user 'deploy' do
end

directory config_dir do
  owner 'deploy'
  group 'www-data'
  recursive true
end

template "#{config_dir}/database.yml" do
  source 'database.yml.erb'
  owner 'deploy'
  group 'www-data'
end
