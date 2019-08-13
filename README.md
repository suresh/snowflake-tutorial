# Snowflake Tutorial
In this tutorial, we would be going through the process of setting Snowflake with sample warehouse. Next, we would be loading a data file onto this warehouse. Last, we would be running sample queries on this warehouse.

## Create Snowflake user profiles

Here is the script for [creating user profiles](scripts/user_profiles.sql)

## Data Loading Steps

* Create File Format Objects 
* Create Stage Objects 
* Stage the Data Files 
* List the Stages Data Files 
* Copy Data into Target Tables 
* Resolve Data Errors if any 
* Verify loaded data 
* Remove successfully loaded data files 

Here is the script for [loading data into Snowflake](scripts/data_loading.sql). Here is the snowsql cli command 

```bash
snowsql -a wg30470.us-east-1 -u etl_user -r anl_write -w etl_write_xs -d sflk_s -s dim	
```

## Sample Queries


## Worked Example


## FAQ

1. What is the difference between securityadmin and sysadmin roles. Why do we get a sysadmin default.

## Reference