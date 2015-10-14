# Install dat with npm
execute 'install_dat' do
  command 'npm install dat -g'
end

execute 'install_taco_nginx' do
  command 'npm install taco-nginx@1.9.0 -g'
end