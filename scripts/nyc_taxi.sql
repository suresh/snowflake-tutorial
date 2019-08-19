use database sfl_s;
use schema dim;

create or replace table green_tripdata_staging (
  vendor_id text,
  lpep_pickup_datetime text,
  lpep_dropoff_datetime text,
  store_and_fwd_flag text,
  rate_code_id text,
  pickup_location_id text,
  dropoff_location_id text,
  passenger_count text,
  trip_distance text,
  fare_amount text,
  extra text,
  mta_tax text,
  tip_amount text,
  tolls_amount text,
  ehail_fee text,
  improvement_surcharge text,
  total_amount text,
  payment_type text,
  trip_type text
);

-- create or replace sequence green_tripdata_staging_seq;

-- create CSV file format
create or replace file format sf_tut_csv_format
  type = 'CSV'
  skip_header=2;

//drop stage sf_tut_trip_stage;
-- create staging area
create or replace stage sf_tut_trips_stage
    file_format = sf_tut_csv_format
    url = 's3://nyc-tlc/trip data';
    
list @sf_tut_trips_stage;

-- load one file from stage
copy into green_tripdata_staging
    from @sf_tut_trips_stage/green_tripdata_2018-01.csv
    on_error = 'skip_file';
    
-- let's look at the table after loading    
select * from green_tripdata_staging;

-- load multiple files using list
copy into green_tripdata_staging
    from @sf_tut_trips_stage
    files = ('green_tripdata_2018-01.csv', 'green_tripdata_2018-02.csv', 'green_tripdata_2018-03.csv')
    on_error = 'skip_file';
    