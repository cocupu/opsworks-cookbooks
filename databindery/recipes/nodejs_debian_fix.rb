# Relying on the OpsWorks setup to install nodejs from debian package

# Create a symlink to the node binary (debian package installs node binary as /usr/bin/nodejs)
# see /usr/share/doc/nodejs/README.Debian on the server for more info
link '/usr/bin/node' do
  to '/usr/bin/nodejs'
end