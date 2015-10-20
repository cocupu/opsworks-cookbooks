# set up daily cron job to run the twitter analyzer

application = 'frontendmasters_twitter_analyzer'
deploy = node[:deploy][application]
current_path = deploy[:current_path]

# set up the cron job
cron "frontendmasters_url_analyzer" do
  hour "4"
  minute "0"
  path "/usr/local/bin"
  user deploy[:user]
  command "cd #{current_path} && bundle exec script/url_analyzer --full 2>&1"
end