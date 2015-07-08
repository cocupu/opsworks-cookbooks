include_recipe 'databindery::apt'

packages = %w(
  elasticsearch openjdk-7-jdk
)

packages.each { |name| package name }

service 'elasticsearch' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
