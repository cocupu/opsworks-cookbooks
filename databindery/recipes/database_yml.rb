config_dir = node[:deploy][:databindery][:deploy_to]

rails_environment = node[:deploy][:databindery][:rails_env]
postgres_host     = node[:opsworks][:layers][:postgres][:instances].first[:private_dns_name] rescue ''

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
