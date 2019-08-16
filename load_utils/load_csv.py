#!/usr/bin/env python
import os
import sys

import snowflake.connector

# Get the password from an appropriate env variable
PASSWORD = os.getenv('SNOWSQL_PWD')

# Get the other login info etc. from the command line.
if len(sys.argv) < 6:
    print("ERROR: Please pass the following command-line parameters in order:")
    print("       user, account, warehouse, database, schema [, password].")
    sys.exit(-1)
else:
    USER = sys.argv[1]
    ACCOUNT = sys.argv[2]
    WAREHOUSE = sys.argv[3]
    DATABASE = sys.argv[4]
    SCHEMA = sys.argv[5]

# Note that the command-line password (if any) overrides the env var (if any).
if len(sys.argv) >= 7:
    PASSWORD = sys.argv[6]

# If the password wasn't set either in the environment var or on command line...
if PASSWORD == None or PASSWORD == '':
    print("ERROR: Set password, e.g. with SNOWSQL_PWD environment variable")
    sys.exit(-2)
    

print("Connecting...")
# -- (> ------------------- SECTION=connect_to_snowflake --------------------
con = snowflake.connector.connect(
  user=USER,
  password=PASSWORD,
  account=ACCOUNT,
  warehouse=WAREHOUSE,
  database=DATABASE,
  schema=SCHEMA
)
# -- <) ---------------------------- END_SECTION ----------------------------

cs = con.cursor()
try:
    cs.execute("put file://data/201808-citibike-tripdata.csv @sf_tut_trips_stage auto_compress=true")
    one_row = cs.fetchone()
    print(one_row[0])
finally:
    cs.close()
con.close()