# Stack: DataBindery

Custom Cookbooks for the Databindery stack

**Note:** This branch has been decomissioned. The necessary parts of these recipes were moved into the deploy scripts within the databindery-api-server code base.  See https://github.com/cocupu/databindery-api-server/tree/master/deploy

## Requirements

In order to run the deploy recipes, you must set a number of attributes.  
In OpsWorks you would usually set these attributes in the **Custom JSON** for the Stack

### Example Custom JSON

```json
{
  "deploy": {
    "databindery_api_server": {
      "database": {
        "adapter": "postgres",
      },
      "elasticsearch": {
        "host": "HOST_URL"
      },
      "aws": {
        "access_key_id": "ACCESS_KEY_ID",
        "secret_access_key": "SECRET_ACCESS_KEY"
      }
    }
  }
}
```

## Other versions of these recipes

This stack assumes that you are deploying the postgres database server separately (ie. relying on Amazon RDS).  
The recipes for deploying a postgres server instance (not currently used) are in the [with-postgres branch](https://github.com/cocupu/opsworks-cookbooks/commit/dfb97f392c6d63d499d52082cdbe8d913a2f49ba)