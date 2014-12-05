require 'fileutils'

include_recipe 'databindery::apt'

packages = %w(
  jetty8
)

packages.each { |name| package name }

service "jetty8" do
  action :enable
end

solr_home = "/var/lib/solr"
template '/etc/default/jetty8' do
  source 'jetty8.erb'
  variables({
    :java_options => "-Xmx256m -Djava.awt.headless=true -Dsolr.solr.home=#{solr_home}"
  })
  notifies :restart, "service[jetty8]"
end


path    = '/usr/local/src'
version = '4.10.2'
base    = "solr-#{version}"
file    = "#{base}.tgz"

remote_file "#{path}/#{file}" do
  source "http://archive.apache.org/dist/lucene/solr/#{version}/#{file}"
  checksum 'a24f73f70e3fcf6aa8fda67444981f78'
  mode 0644
end

ruby_block 'Extract Solr' do
  block do
    Chef::Log.info "Extracting Solr archive #{path}/#{file} into #{path}"
    `tar xzf #{path}/#{file} -C #{path}`
    raise "Failed to extract Solr package" unless File.exists?("#{path}/#{base}")
  end
  action :create
  not_if do
    File.exists?("#{path}/#{base}")
  end
end

jetty_home = "/usr/share/jetty8"
war_source = File.join(path, base, 'dist', "solr-#{version}.war")
war_target = "#{jetty_home}/webapps/solr.war"

ruby_block 'Copy Solr war into Jetty webapps folder' do
  block do
    Chef::Log.info "Copying solr war to #{war_target}"
    FileUtils.cp(war_source, war_target)
    FileUtils.chown_R('jetty', 'adm', war_target)
    raise "Failed to copy Solr war" unless File.exists?(war_target)
  end
  action :create
  notifies :restart, "service[jetty8]"
  not_if do
    system("diff #{war_source} #{war_target}")
  end
end

solr_lib_ext = File.join(path, base, 'example', 'lib', 'ext')
jetty_lib_ext = File.join(jetty_home, '/lib/ext')

ruby_block 'Copy ext libs into Jetty' do
  block do
    Chef::Log.info "Copying into #{jetty_lib_ext}"
    system("rsync -av --delete-after #{solr_lib_ext}/ #{jetty_lib_ext}")
    raise "Failed to copy ext lib files" if Dir.glob(File.join(jetty_lib_ext, 'log4j-*.jar')).empty?
  end
  action :create
  notifies :restart, "service[jetty8]"
  not_if do
    system("diff -r #{jetty_lib_ext} #{solr_lib_ext}")
  end
end

directory solr_home do
  owner 'jetty'
  group 'adm'
  mode "755"
  recursive true
  action :create
  notifies :restart, "service[jetty8]"
end

template "#{solr_home}/solr.xml" do
  source 'solr.xml'
  owner 'jetty'
  group 'adm'
  mode "644"
  action :create
  notifies :restart, "service[jetty8]"
end
