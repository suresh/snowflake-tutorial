-- create table for loading citibike data file
CREATE TABLE trips_raw (
  trip_duration numeric,
  start_time timestamp without time zone,
  stop_time timestamp without time zone,
  start_station_id integer,
  start_station_name text,
  start_station_latitude numeric,
  start_station_longitude numeric,
  end_station_id integer,
  end_station_name text,
  end_station_latitude numeric,
  end_station_longitude numeric,
  bike_id integer,
  user_type text,
  birth_year text,
  gender text
);

-- check if this table is created
select * from trips_raw;

//drop table trips_raw;


-- create CSV file format
create or replace file format sf_tut_trips_csv_format
  type = 'CSV'
  field_delimiter = ','
  skip_header=1;

//drop stage sf_tut_trip_stage;
-- create staging area
create or replace stage sf_tut_trips_stage
    file_format = sf_tut_trips_csv_format;
    
list @sf_tut_trips_stage;

-- run python file load_csv for getting the file to internal stage