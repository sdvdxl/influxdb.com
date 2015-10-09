---
title: Database management
aliases:
  - /docs/v0.9/query_language/database_administration.html
  - /docs/v0.9/query_language/database_management.html
---

InfluxQL offers a full suite of administrative commands. 

* [Data management](../query_language/database_management.html#data-management)    
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Create a database with `CREATE DATABASE`](../query_language/database_management.html#create-a-database-with-create-database)    
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete a database with `DROP DATABASE`](../query_language/database_management.html#delete-a-database-with-drop-database)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete series with `DROP SERIES`](../query_language/database_management.html#delete-series-with-drop-series)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete measurements with `DROP MEASUREMENT`](../query_language/database_management.html#delete-measurements-with-drop-measurement)  

* [Retention policy management](../query_language/database_management.html#retention-policy-management)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Create retention policies with `CREATE RETENTION POLICY`](../query_language/database_management.html#create-retention-policies-with-create-retention-policy)    
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Modify retention policies with `ALTER RETENTION POLICY`](../query_language/database_management.html#modify-retention-policies-with-alter-retention-policy)   
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete retention policies with `DROP RETENTION POLICY`](../query_language/database_management.html#delete-retention-policies-with-drop-retention-policy)   

The examples in the sections below use InfluxDB's [Command Line Interface (CLI)](../introduction/getting_started.html). You can also execute the commands using the HTTP API; simply  send a `GET` request to the `/query` endpoint and include the command in the URL parameter `q`. See the [Querying Data](../guides/querying_data.html) guide for more on using the HTTP API.

> **Note:** When authentication is enabled, only admin users can execute most of the commands listed on this page. See the documentation on [authentication and authorization](../administration/authentication_and_authorization.html) for more information.

## Data management

### Create a database with CREATE DATABASE
---
The `CREATE DATABASE` query takes the following form, where `IF NOT EXISTS` is optional:
```sql
CREATE DATABASE <database_name> IF NOT EXISTS
```

Create the database ` NOAA_water_database`:
```sh
> CREATE DATABASE NOAA_water_database
>
```

Create the database `NOAA_water_database` only if it doesn't already exist:
```sh
> CREATE DATABASE  NOAA_water_database
>
```

InfluxDB provides no CLI response when it successfully creates a new database. In the first example, InfluxDB would return `ERR: database already exists` if the `NOAA_water_database` database already existed. In the second example, InfluxDB would not return an error if the `NOAA_water_database` database already existed.

### Delete a database with DROP DATABASE
---
The `DROP DATABASE` query takes the following form:
```sql
DROP DATABASE <database_name> 
```

CLI example:
```sh
> DROP DATABASE NOAA_water_database
>
```

InfluxDB provides no CLI response when it successfully deletes a database. It returns `ERR: database not found` if the specified database does not exist.

### Delete series with DROP SERIES
---
The `DROP SERIES` query deletes [series](../concepts/glossary.html#series) in your database and takes the following form, where the query requires either the `FROM` clause or the `WHERE` clause:
```sql
DROP SERIES FROM <measurement_name[,measurement_name]> WHERE <tag_key='tag_value'>
```

Delete all series from a single measurement:
```sql
> DROP SERIES FROM h2o_feet
```

Delete series from a measurement that have a specific tag set:
```sql
> DROP SERIES FROM h2o_feet WHERE location = 'santa_monica'
```

Delete series across all measurements in your database that have a specific tag set:
```sql
> DROP SERIES WHERE location = 'santa_monica'
```

InfluxDB provides no CLI response when it successfully deletes series.

<dt> Currently, InfluxDB does not support regular expressions with `DROP SERIES`. See GitHub Issue [#4276](https://github.com/influxdb/influxdb/issues/4276) for more information. </dt>

### Delete measurements with DROP MEASUREMENT
---
The `DROP MEASUREMENT` query deletes all data from the specified measurement and takes the following form:
```sql
DROP MEASUREMENT <measurement_name>
```

Delete the measurement `h2o_feet`:
```sql
> DROP MEASUREMENT h2o_feet
```

InfluxDB provides no CLI response when it successfully deletes measurements.

<dt> Currently, InfluxDB does not support regular expressions with `DROP MEASUREMENTS`. See GitHub Issue [#4275](https://github.com/influxdb/influxdb/issues/4275) for more information. </dt>

## Retention Policy Management
The following sections cover how to list existing retention policies, create retention policies, change retention policies, and delete retention policies. Note that when you create a database, InfluxDB automatically creates a retention policy named `default` which has infinite retention. You may disable that auto-creation in the configuration file.

### Create retention policies with CREATE RETENTION POLICY
---
The `CREATE RETENTION POLICY` query takes the following form, where `DEFAULT` is optional:
```sql
CREATE RETENTION POLICY <retention_policy_name> ON <database_name> DURATION <duration> REPLICATION <n> DEFAULT
```

Create a retention policy called `one_day_only` for the database `NOAA_water_database` with a one day [duration](../concepts/glossary.html#duration) and a [replication factor](../concepts/glossary.html#replication-factor) of one:
```sql
> CREATE RETENTION POLICY one_day_only ON NOAA_water_database DURATION 1d REPLICATION 1
>
```

Create the same retention policy as the one in the example above, but set it as the default retention policy for the database. Does this mean all data before this dropped? Every point that you write to the database without specifying a retention policy is subject to the default retention policy.
```sql
> CREATE RETENTION POLICY one_day_only ON NOAA_water_database DURATION 1d REPLICATION 1 DEFAULT
>
```

InfluxDB provides no CLI response when it successfully creates a retention policy.

Other options for specifying the `DURATION` of the retention policy are listed below. Note that the minimum retention period is one hour.  
`m` minutes  
`h` hours  
`d` days  
`w` weeks  
`INF` infinite

### Modify retention policies with ALTER RETENTION POLICY
---
The `ALTER RETENTION POLICY` query takes the following form, where you must set at least one of the following flags: `DURATION`, `REPLICATION`, or `DEFAULT`:
```sql
ALTER RETENTION POLICY <retention_policy_name> ON <database_name> DURATION <duration> REPLICATION <n> DEFAULT
```

First, create the retention policy `what_is_time` with a `DURATION` of two days:
```sql
> CREATE RETENTION POLICY what_is_time ON NOAA_water_database DURATION 2d REPLICATION 1
```

Modify `what_is_time` to have a three week `DURATION` and make it the `DEFAULT` retention policy for `NOAA_water_database`:
```sql
> ALTER RETENTION POLICY what_is_time ON NOAA_water_database DURATION 2w DEFAULT
```

InfluxDB provides no CLI response when it successfully alters a retention policy.

### Delete retention policies with DROP RETENTION POLICY
Delete a retention policy with:
```sql
DROP RETENTION POLICY <retention_policy_name> ON <database_name>
```

CLI example:
```sh
> DROP RETENTION POLICY what_is_time ON NOAA_water_database
>
```

InfluxDB provides no CLI response when it successfully deletes a database.

>**Note:** If you attempt `DROP` a retention policy that is the default retention policy for the database InfluxDB does not delete the policy and returns the error: `ERR: retention policy is default`. `CREATE` a new default policy or `ALTER` an already existing policy to be the default before deleting the retention policy.


