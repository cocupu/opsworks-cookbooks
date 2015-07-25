# Stack: DataBindery

Cookbooks for the Databindery stack

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
        "host": "HOST_URL",
        "database": "DB_NAME",
        "username": "DB_USERNAME",
        "password": "DB_PASSPHRASE"
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