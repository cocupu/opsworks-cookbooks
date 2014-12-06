template node['deploy']['databindery']['deploy_to'] + "shared/config/solr.yml" do
  source 'solr.yml.erb'
  owner  'deploy'
  groud  'www-data'
  mode   '644'
  action :create
  variables({
    :environment => node['deploy']['databindery']['rails_env']
  })
end

link node['deploy']['databindery']['deploy_to'] + "current/config/solr.yml" do
  to     node['deploy']['databindery']['deploy_to'] + "shared/config/solr.yml"
  action :create
end
