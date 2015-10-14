# Stack: DataBindery

Custom Cookbooks for the Databindery stack

* Berksfile adds opsworks cookbooks so setup can call opsworks_nodejs recipe
* databindery::dat recipe installs dat

## Requirements


## Other versions of these recipes

This stack assumes that you are deploying the postgres database server separately (ie. relying on Amazon RDS).  
The recipes for deploying a postgres server instance (not currently used) are in the [with-postgres branch](https://github.com/cocupu/opsworks-cookbooks/commit/dfb97f392c6d63d499d52082cdbe8d913a2f49ba)
For reference, there's a branch with recipes for deploying elasticsearch and postgres at https://github.com/cocupu/opsworks-cookbooks/tree/elasticsearch_and_postgres