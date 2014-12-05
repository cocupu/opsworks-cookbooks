config_dir = node[:deploy][:databindery][:deploy_to] + "/shared/config"

rails_environment = node[:deploy][:databindery][:rails_env]
postgres_host     = 'postgres1'

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
  variables({
    :environment => rails_environment,
    :host        => postgres_host,
    :password    => 'banana',
  })
end
