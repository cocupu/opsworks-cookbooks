dbname = 'databindery'

execute "create-database-user" do
  exists = <<-EOF
    psql -U postgres -c "select * from pg_user where usename='#{dbname}'" | grep -c #{dbname}
  EOF
  command "sudo -u postgres createuser -sw #{dbname}"
  not_if exists
end


execute "create-database" do
  exists = <<-EOF
    psql -U postgres -c "select * from pg_database WHERE datname='#{dbname}'" | grep -c #{dbname}
  EOF
  command "sudo -u postgres createdb -O #{dbname} -E utf8 -T template0 #{dbname}"
  not_if exists
end
