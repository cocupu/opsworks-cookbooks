include_recipe 'deploy'

# deploy recipe for chef to run when deploying this code

application = 'frontendmasters_twitter_analyzer'
deploy = node[:deploy][application]
user = deploy[:user]
deploy_shared_path = deploy[:deploy_to]+"/shared"
current_path = deploy[:current_path]

mounted_volume_path = '/mnt/frontendmasters'
# this directory will be writeable even if the ebs volume is not mounted
# but will write to the ebs volume if it is mounted
customer_data_dir = "/home/#{user}/frontendmasters"



# set up the deploy directory and deploy the code
# (this is not automatically done because frontendmasters app is an 'other' app )
opsworks_deploy_dir do
  user deploy[:user]
  group deploy[:group]
  path deploy[:deploy_to]
end

# deploy the code
opsworks_deploy do
  deploy_data deploy
  app application
end

# ensure that shared data dir exists
directory "#{deploy_shared_path}/data" do
  owner user
  group  'www-data'
  action :create
end
# symlink to the shared data dir we just generated
link "#{current_path}/data" do
  to     "#{deploy_shared_path}/data"
  owner  user
  group  'www-data'
  action :create
end


# ensure that shared output dir exists
directory "#{deploy_shared_path}/output" do
  owner user
  group  'www-data'
  action :create
end
# delete the empty output dir that came from git
directory "#{current_path}/output" do
  recursive true
  action :delete
end
# symlink to the shared output dir we just generated
link "#{current_path}/output" do
  to     "#{deploy_shared_path}/output"
  owner  user
  group  'www-data'
  action :create
end


# the url_analyzer 'publishes' to a dat repo at #{current_path}/dat_repo
# symlink that dir to #{customer_data_dir}/trending_urls

# ensure that the dat repo dir exists
directory "#{customer_data_dir}/trending_urls" do
  owner  user
  group  'www-data'
  action :create
end

# route the analyzer's dat_repo path to the real home for the dat repo
link "#{current_path}/dat_repo" do
  to     "#{customer_data_dir}/trending_urls"
  owner  user
  group  'www-data'
  action :create
end

execute 'bundle install' do
  command 'bundle install'
  cwd     current_path
end
