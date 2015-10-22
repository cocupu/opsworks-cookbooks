# set up the server to host frontendmasters data

mounted_volume_path = '/mnt/frontendmasters'
# this directory will be writeable even if the ebs volume is not mounted
# but will write to the ebs volume if it is mounted
customer_data_dir = "/home/frontendmasters/frontendmasters"

# symlink `customer_data_dir` to a mounted ebs volume if the ebs volume is mounted
# this way running
#     $ dat push ssh://frontendmasters@api.databindery.com:frontendmasters/trending_urls
# will write to the mounted volume.
# In the future, these things will probably move around, but the pattern of accessing
# a dat repo at +username+/+pool_short_name+ (ie. frontendmasters/trending_urls)
# will stay the same
link customer_data_dir do
  to     mounted_volume_path
  owner  'frontendmasters'
  group  'www-data'
  action :create
  only_if { Dir.exist?(mounted_volume_path) }
end