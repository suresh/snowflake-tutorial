use role sysadmin;
-- 
CREATE WAREHOUSE etl_write_xs WITH WAREHOUSE_SIZE = 'XSMALL' WAREHOUSE_TYPE = 'STANDARD' 
AUTO_SUSPEND = 600 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD' COMMENT = 'etl warehouse';

--
use role securityadmin;
Create or Replace Role anl_admin comment='Created to manage admin activities';
Create or Replace Role anl_write comment='Created to managed dev activities';
Create or Replace Role anl_read comment='Created to managed BI activities';

--create users
create or replace user admin_user password = 'adminuser' default_role = anl_admin must_change_password = false;
create or replace user etl_user password = 'etluser' default_role = anl_write must_change_password = false;
create or replace user read_user password = 'readuser' default_role = anl_read must_change_password = false;

--assign roles to user
grant role anl_Admin to user admin_user;
grant role anl_write to user etl_user;
grant role anl_read to user read_user; 

--hierarchy role setup
grant role anl_admin to role SYSADMIN; -- all the objects created by anl_admin can be accessed by sysadmin
grant role anl_write, anl_read to role anl_admin; -- all roles roles up to anl_admin
grant role anl_read to role anl_write; -- read role can access objects created by write user but not admin user

-- show the privileges for anl_read
show grants on role anl_read;

-- create database and schemas
use role sysadmin;
create database sflk_s;
create schema fact;
create schema dim;

-- grant access to db
grant usage,monitor,create schema   on database sflk_s to role anl_admin;
grant usage,monitor,create schema   on database sflk_s to role anl_write;

-- grant access to schema sflk_s
use database sflk_s;
grant modify,monitor,operate,usage  on warehouse etl_write_xs to role anl_admin;

grant usage  on warehouse etl_write_xs to role anl_write;

-- grant access to schema
grant all on schema sflk_s.dim to role anl_admin;
grant all on schema sflk_s.fact to role anl_admin;
grant all on schema sflk_s.dim to role anl_write;
grant all on schema sflk_s.fact to role anl_write;
grant usage on schema sflk_s.dim to role anl_read;
grant usage on schema sflk_s.fact to role anl_read;

-- schema level access
grant all on schema sflk_s.dim to role anl_admin;
grant all on schema sflk_s.fact to role anl_admin;
grant all on schema sflk_s.dim to role anl_write;
grant all on schema sflk_s.fact to role anl_write;
grant usage on schema sflk_s.dim to role anl_read;
grant usage on schema sflk_s.fact to role anl_read;

-- table level access
grant all on all tables in schema sflk_s.dim  to role anl_admin;
grant all on all tables in schema sflk_s.fact to role anl_admin;
grant all on all tables in schema sflk_s.dim  to role anl_write;
grant all on all tables in schema sflk_s.fact to role anl_write;
grant select on all tables in schema sflk_s.dim  to role anl_read;
grant select on all tables in schema sflk_s.fact to role anl_read;

-- view level access
grant all on all views in schema sflk_s.dim  to role anl_admin;
grant all on all views in schema sflk_s.fact to role anl_admin;
grant all on all views in schema sflk_s.dim  to role anl_write;
grant all on all views in schema sflk_s.fact to role anl_write;
grant select on all views in schema sflk_s.dim  to role anl_read;
grant select on all views in schema sflk_s.fact to role anl_read;
