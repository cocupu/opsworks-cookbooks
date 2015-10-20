include_recipe 'databindery::apt'

packages = %w(
  openjdk-7-jdk
)

package 'elasticsearch' do
  version '1.6.2' # to avoid bug in 1.6.0 https://github.com/elastic/elasticsearch/issues/11594
  action :install
end

template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  owner  'root'
  group  'root'
  mode   '644'
  action :create
  variables({
                :elasticsearch_host =>      node['deploy']['databindery_api_server']['elasticsearch']['host']
            })
end

packages.each { |name| package name }

service 'elasticsearch' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
