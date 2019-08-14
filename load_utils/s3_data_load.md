# Copying Data from an External Location
To load data from files already staged in an external location (i.e. your own S3 bucket) into a table, use the `COPY INTO <table>` command.

For example:

```sql
 # Copying Data
con.cursor().execute("""
COPY INTO testtable FROM s3://<your_s3_bucket>/data/
    CREDENTIALS = (
        aws_key_id='{aws_access_key_id}',
        aws_secret_key='{aws_secret_access_key}')
    FILE_FORMAT=(field_delimiter=',')
""".format(
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY))
```

Where s3://<your_s3_bucket>/data/ specifies the name of your S3 bucket, the files in the bucket are prefixed with data, and the bucket is accessible by the specified AWS credentials.