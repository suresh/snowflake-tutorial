-- create table home_sales

use database sflk_s;
use schema dim;

create or replace table home_sales (
  city string,
  zip string,
  state string,
  type string default 'Residential',
  sale_date timestamp_ntz,
  price string
  );


-- create json file format
create or replace file format sf_tut_json_format
  type = 'JSON'
  strip_outer_array = true;

-- create staging area
create or replace stage sf_tut_stage
    file_format = sf_tut_json_format;

-- send local file to staging
-- put file:///Users/suresh/Projects/snowflake-tutorial/data/sales.json @sf_tut_stage auto_compress=true;

-- look at staging area
list @sf_tut_stage;

-- copy data into home_sales table
copy into home_sales(city, state, zip, sale_date, price)
   from (select substr(parse_json($1):location.state_city,4), substr(parse_json($1):location.state_city,1,2), parse_json($1):location.zip, to_timestamp_ntz(parse_json($1):sale_date), parse_json($1):price
   from @sf_tut_stage/sales.json.gz t)
   on_error = 'continue';

-- check relational table
select * from home_sales;
