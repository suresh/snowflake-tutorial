create or replace temporary table contacts_raw (
  id integer,
  last_name string,
  first_name string,
  company string,
  email string,
  workphone string,
  cellphone string,
  streetaddress string,
  city string,
  postalcode string);

-- create CSV file format
create or replace file format sf_tut_csv_format
  type = 'CSV'
  field_delimiter = '|'
  skip_header=1;

//drop stage sf_tut_trip_stage;
-- create staging area
create or replace stage sf_tut_contacts_stage
    file_format = sf_tut_csv_format
    url = 's3://snowflake-docs';
    
list @sf_tut_contacts_stage;

-- load one file from stage
copy into contacts_raw
    from @sf_tut_contacts_stage/tutorials/dataloading/contacts1.csv
    on_error = 'skip_file';
    
-- let's look at the table after loading    
select * from contacts_raw;
