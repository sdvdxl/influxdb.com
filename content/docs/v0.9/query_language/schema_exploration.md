---
title: Schema Exploration
---

InfluxQL is an SQL-like query language for interacting with data in InfluxDB. The following sections cover useful query syntax for exploring your schema (that is, how you set up your time series data):

* [See all databases with `SHOW DATABASES`](../query_language/schema_exploration.html#see-all-databases-with-show-databases)
* [Explore retention policies with `SHOW RETENTION POLICIES`](../query_language/schema_exploration.html#explore-retention-policies-with-show-retention-policies)
* [Explore series with `SHOW SERIES`](../query_language/schema_exploration.html#explore-series-with-show-series)
* [Explore measurements with `SHOW MEASUREMENTS`](../query_language/schema_exploration.html#explore-measurements-with-show-measurements)
* [Explore tag keys with `SHOW TAG KEYS`](../query_language/schema_exploration.html#explore-tag-keys-with-show-tag-keys)
* [Explore tag values with `SHOW TAG VALUES`](../query_language/schema_exploration.html#explore-tag-values-with-show-tag-values)
* [Explore field keys with `SHOW FIELD KEYS`](../query_language/schema_exploration.html#explore-field-keys-with-show-field-keys)
* [See statistics for your installation with `SHOW STATS`](../query_language/schema_exploration.html#see-statistics-about-your-installation-with-show-stats)
* [Show diagnostic information about your installation with `SHOW DIAGNOSTICS`](../query_language/schema_exploration.html#show-diagnostic-information-about-your-installation-with-show-diagnostics)

The examples below query data using [InfluxDB's Command Line Interface (CLI)](../introduction/getting_started.html). See the [Querying Data](../guides/querying_data.html) guide for how to directly query data with the HTTP API.

**Sample data**  

This document uses the same sample data as the [Data Exploration](../query_language/data_exploration.html) page. Note that some of the measurements and data in the database are fictional - they're meant to make the next sections more explanatory and (hopefully) more interesting. The next sections will get you acquainted with the schema of the sample data in the `NOAA_water_database` database.

## See all databases with `SHOW DATABASES`
Get a list of all the databases in your system by entering:
```sql
SHOW DATABASES
```

CLI example:
```sh
> SHOW DATABASES
name: databases
---------------
name
NOAA_water_database
```

## Explore retention policies with `SHOW RETENTION POLICIES`
The `SHOW RETENTION POLICIES` query lists the existing [retention policies](../concepts/glossary.html#retention-policy) on a given database, and it takes the following form:
```sql
SHOW RETENTION POLICIES ON <database_name>
```

CLI example:
```sql
> SHOW RETENTION POLICIES ON NOAA_water_database
```

CLI response:
```sh
name	    duration	 replicaN	 default
default	 0		       1		       true
```

The first column of the output contains the names of the different retention policies in the specified database. The second column shows the [duration](../concepts/glossary.html#duration) and the third column shows the [replication factor](../concepts/glossary.html#replication-factor) of the retention policy. The fourth column specifies if the retention policy is the default retention policy for the database.

The following example shows a hypothetical CLI response where there are four different retention policies in the database, and where the default retention policy is `three_days_only`:

```sh
name		           duration	 replicaN	 default
default		        0		       1		       false
two_days_only	   48h0m0s		 1		       false
one_day_only	    24h0m0s		 1		       false
three_days_only	 72h0m0s		 1		       true
```

## Explore series with `SHOW SERIES`
The `SHOW SERIES` query returns the distinct [series](../concepts/glossary.html#series) in your database and takes the following form, where the `FROM` and `WHERE` clauses are optional:

```sql
SHOW SERIES FROM <measurement_name> WHERE <tag_key>=<'tag_value'>
```

Return all series in the database `NOAA_water_database`:
```sql
> SHOW SERIES
```

CLI response:  
```sh
name: average_temperature
-------------------------
_key						                                   location
average_temperature,location=coyote_creek	   coyote_creek
average_temperature,location=santa_monica	   santa_monica


name: h2o_feet
--------------
_key						                        location
h2o_feet,location=coyote_creek	   coyote_creek
h2o_feet,location=santa_monica	   santa_monica


name: h2o_pH
------------
_key						                      location
h2o_pH,location=coyote_creek	   coyote_creek
h2o_pH,location=santa_monica	   santa_monica


name: h2o_quality
-----------------
_key						                                     location	       randtag
h2o_quality,location=coyote_creek,randtag=1	   coyote_creek	   1
h2o_quality,location=coyote_creek,randtag=2	   coyote_creek	   2
h2o_quality,location=coyote_creek,randtag=3	   coyote_creek	   3
h2o_quality,location=santa_monica,randtag=3	   santa_monica	   3
h2o_quality,location=santa_monica,randtag=2	   santa_monica	   2
h2o_quality,location=santa_monica,randtag=1	   santa_monica	   1


name: h2o_temperature
---------------------
_key					                                location
h2o_temperature,location=coyote_creek	   coyote_creek
h2o_temperature,location=santa_monica	   santa_monica
```

`SHOW SERIES` organizes its output by [measurement](../concepts/glossary.html#measurement) name. From the return you can see that the data in the database `NOAA_water_database` have five different measurements and 14 different series. The measurements are `average_temperature`, `h2o_feet`, `h2o_pH`, `h2o_quality`, and `h2o_temperature`. Every measurement
has the [tag key](../concepts/glossary.html#tag-key) `location` with the [tag values](../concepts/glossary.html#tag-value) `coyote_creek` and `santa_monica` - that makes 10 series. The measurement `h2o_quality` has the additional tag key `randtag` with the tag values `1`,`2`, and `3` - that makes 14 series.

Return series for a specific measurement:
```sql
> SHOW SERIES FROM h2o_quality
```

CLI response:
```sh
name: h2o_quality
-----------------
_key						                                     location	       randtag
h2o_quality,location=coyote_creek,randtag=1	   coyote_creek	   1
h2o_quality,location=coyote_creek,randtag=2	   coyote_creek	   2
h2o_quality,location=coyote_creek,randtag=3	   coyote_creek	   3
h2o_quality,location=santa_monica,randtag=3	   santa_monica	   3
h2o_quality,location=santa_monica,randtag=2	   santa_monica	   2
h2o_quality,location=santa_monica,randtag=1	   santa_monica	   1
```

Return series for a specific measurement and tag set:
```sql
> SHOW SERIES FROM h2o_quality WHERE location = 'coyote_creek'
```

CLI response:
```sh
name: h2o_quality
-----------------
_key						                                     location	       randtag
h2o_quality,location=coyote_creek,randtag=1	   coyote_creek	   1
h2o_quality,location=coyote_creek,randtag=2	   coyote_creek	   2
h2o_quality,location=coyote_creek,randtag=3	   coyote_creek	   3
```

## Explore measurements with `SHOW MEASUREMENTS`
The `SHOW MEASUREMENTS` query returns all [measurements](../concepts/glossary.html#measurement) in your database and it takes the following form, where the `WHERE` clause is optional:
```sql
SHOW MEASUREMENTS WHERE <tag_key>=<'tag_value'>
```

Return all measurements in the `NOAA_water_database` database:
```sql
> SHOW MEASUREMENTS
```

CLI response:
```sh
name: measurements
------------------
name
average_temperature
h2o_feet
h2o_pH
h2o_quality
h2o_temperature
```

From the output you can see that the database `NOAA_water_database` has five measurements: `average_temperature`, `h2o_feet`, `h2o_pH`, `h2o_quality`, and `h2o_temperature`.

Return measurements where the tag key `randtag` equals `1`:
```sql
> SHOW MEASUREMENTS WHERE randtag = '1'
```

CLI response:
```sh
name: measurements
------------------
name
h2o_quality
```

Only the measurement `h2o_quality` contains the tag set `randtag = 1`.

Use a regular expression to return measurements where the tag key `randtag` is a digit:
```sql
SHOW MEASUREMENTS WHERE randtag =~ /\d/
```

CLI response:
```sh
name: measurements
------------------
name
h2o_quality
```

## Explore tag keys with SHOW TAG KEYS
`SHOW TAG KEYS` returns the [tag keys](../concepts/glossary.html#tag-key) associated with each measurement and takes the following form, where the `FROM` clause is optional:
```sql
SHOW TAG KEYS FROM <measurement_name>
```

Return all tag keys that are in the database `NOAA_water_database`:
```sql
> SHOW TAG KEYS
```

CLI response:
```sh
name: average_temperature
-------------------------
tagKey
location


name: h2o_feet
--------------
tagKey
location


name: h2o_pH
------------
tagKey
location


name: h2o_quality
-----------------
tagKey
location
randtag


name: h2o_temperature
---------------------
tagKey
location
```

InfluxDB organizes the output by measurement. Notice that each of the five measurements has the tag key `location` and that the measurement `h2o_quality` also has the tag key `randtag`.

Return the tag keys for a specific measurement:
```sql
> SHOW TAG KEYS FROM h2o_temperature
```

CLI response:
```sh
name: h2o_temperature
---------------------
tagKey
location
```

## Explore tag values with SHOW TAG VALUES
The `SHOW TAG VALUES` query returns the set of [tag values](../concepts/glossary.html#tag-value) for a specific tag key across all measurements in the database. It takes the following form, where the `FROM` clause is optional:
```sql
SHOW TAG VALUES FROM <measurement_name> WITH KEY = tag_key
```

Return the tag values for the tag key `randtag` across all measurements in the database `NOAA_water_database`:
```sql
> SHOW TAG VALUES WITH KEY = randtag
```

CLI response:
```sh
name: randtagTagValues
----------------------
randtag
1
2
3
```

Return the tag values for the tag key `randtag` for a specific measurement in the `NOAA_water_database` database:
```sql
> SHOW TAG VALUES FROM average_temperature WITH KEY = randtag
```

CLI response:
```sh
```

The measurement `average_temperature` doesn't have the tag key `randtag` so InfluxDB returns nothing.

## Explore field keys with `SHOW FIELD KEYS`
The `SHOW FIELD KEYS` query returns the [field keys](../concepts/glossary.html#field-key) across each measurement in the database. It takes the following form, where the `FROM` clause is optional:

```sql
SHOW FIELD KEYS FROM <measurement_name>
```

Return the field keys across all measurements in the database `NOAA_water_database`:

```sql
> SHOW FIELD KEYS
```

CLI response:
```sh
name: average_temperature
-------------------------
fieldKey
degrees


name: h2o_feet
--------------
fieldKey
level description
water_level


name: h2o_pH
------------
fieldKey
pH


name: h2o_quality
-----------------
fieldKey
index


name: h2o_temperature
---------------------
fieldKey
degrees
```

Return the field keys in the measurement `h2o_feet` in the database `NOAA_water_database`:

```sql
> SHOW FIELD KEYS FROM h2o_feet
```

CLI response:

```sh
name: h2o_feet
--------------
fieldKey
level description
water_level
```

## See statistics for your installation with `SHOW STATS`

Show a series of statistics related to your InfluxDB instance

```sql
> SHOW STATS
```

CLI response:

```sh
name: engine
tags: path=/Users/johnzampolin/.influxdb/data/telegraf/default/65, version=bz1
blks_write	blks_write_bytes	blks_write_bytes_c	points_write	points_write_dedupe
----------	----------------	------------------	------------	-------------------
227422		4781938			6382683			227422		227422


name: httpd
tags: bind=:8086
points_written_ok	query_req	query_resp_bytes	req	write_req	write_req_bytes
-----------------	---------	----------------	---	---------	---------------
227684			30		5027			899	869		15178945


name: shard
tags: engine=bz1, id=65, path=/Users/johnzampolin/.influxdb/data/telegraf/default/65
fields_create	series_create	write_points_ok	write_req
-------------	-------------	---------------	---------
0		268		227684		869


name: wal
tags: path=/Users/johnzampolin/.influxdb/wal/_internal/monitor/66
auto_flush	meta_flush
----------	----------
8671		    14


name: wal
tags: path=/Users/johnzampolin/.influxdb/wal/_internal/monitor/67
auto_flush	flush_duration		idle_flush	mem_size	meta_flush	points_flush	points_write	points_write_req	series_flush
----------	--------------		----------	--------	----------	------------	------------	----------------	------------
8659		2.966561441000001	868		934		14		17356		17376		869			17356


name: write
-----------
point_req	point_req_local	req	write_ok
245060		245060		1738	1738


name: runtime
-------------
Alloc		Frees		HeapAlloc	HeapIdle	HeapInUse	HeapObjects	HeapReleased	HeapSys		Lookups	Mallocs		NumGC	NumGoroutine	PauseTotalNs	Sys		TotalAlloc
96657936	19481852	96657936	47718400	108355584	898912		2121728		156073984	7262	20380764	95	50		54495600	168606776	5823932752
```

> **Note:** Depending on your local configuration there may be multiple `name: engine`, `name: shard`, and `name: wal` fields

## Show diagnostic information about your installation with `SHOW DIAGNOSTICS`

Retrieve a collection of diagnostic information helpful for troubleshooting.  

```sql
> SHOW DIAGNOSTICS
```

CLI response:

```sh
name: build
-----------
Branch   Commit				            	  	               Version
0.9.4	   c4f85f84765e27bfb5e58630d0dea38adeacf543	0.9.4.1


name: runtime
-------------
GOARCH	GOMAXPROCS	  GOOS	     version
amd64	 8		          darwin	   go1.5.1


name: network
-------------
hostname
eruditorum.local


name: system
------------
PID	  currentTime		                  started  			         	         uptime
30780	2015-10-16T21:53:42.118130213Z	2015-10-16T19:28:58.069413146Z	2h24m44.048717342s

```
