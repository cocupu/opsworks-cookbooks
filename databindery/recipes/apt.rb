include_recipe 'apt::default'

apt_repository 'elastic' do
  uri          'http://packages.elastic.co/elasticsearch/1.6/debian'
  distribution 'stable'
  components   ['main']
  key          'https://packages.elastic.co/GPG-KEY-elasticsearch'
end

# apt_repository 'postgres' do
#   uri          'http://apt.postgresql.org/pub/repos/apt/'
#   distribution 'trusty-pgdg'
#   components   ['main']
#   key          'https://www.postgresql.org/media/keys/ACCC4CF8.asc'
# end
