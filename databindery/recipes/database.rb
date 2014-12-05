dbname = 'databindery'
dbpass = node['deploy']['databindery']['database']['password']

packages = %w(
  postgresql
  postgresql-contrib
)

packages.each { |name| package name }

execute "create-database-user" do
  exists = <<-EOF
    sudo -u postgres psql -t -c "select usename from pg_user where usename='databindery'" | grep -c #{dbname}
  EOF
  command "sudo -u postgres psql -t -c \"create user #{dbname} with password '#{dbpass}'\""
  not_if exists
end


execute "create-database" do
  exists = <<-EOF
    sudo -u postgres psql -t -c "select datname from pg_database WHERE datname='#{dbname}'" | grep -c #{dbname}
  EOF
  command "sudo -u postgres createdb -O #{dbname} -E utf8 -T template0 #{dbname}"
  not_if exists
end
