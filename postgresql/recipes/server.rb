execute "run apt-get update" do
  command 'apt-get update'
  action :run
end

packages = %w(
  libpq-dev
  git-core
  curl
  zlib1g-dev
  libssl-dev
  libreadline-dev
  libyaml-dev
  libsqlite3-dev
  sqlite3
  libxml2-dev
  libxslt1-dev
  postgresql-contrib
)

packages.each { |name| package name }
