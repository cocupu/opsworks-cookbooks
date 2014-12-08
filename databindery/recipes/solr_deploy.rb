user 'deploy' do
  not_if { Kernel::system('id deploy') }
end

node['deploy'].each do |application, deploy|
  if deploy['application'] != 'solr_configuration'
    puts "Skipping application #{application}"
    Chef::Log.debug("Skipping application #{application}")
    next
  else
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end
end
