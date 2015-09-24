---
title: Downsampling and Data Retention
---

InfluxDB is built to ingest tends or hundreds of thousands of data points per second. That much data can quickly add up, creating storage concerns. A natural solution is to downsample the data, keeping high precision raw data for only a limited time, and storing lower precision summarized data much longer or forever. This guide will show you how to combine two InfluxDB features -- retention policies and continuous queries -- to easily and automatically downsample and expire data. This will speed up common queries and keep storage needs from growing out of control.

## Retention Policies

First we will discuss the retention of data. In general, InfluxDB is poor at processing deletes. One of the fundamental assumptions in the architecture of the tool is that deletes are infrequent and need not be highly performant. However, InfluxDB also recognizes the necessity of purging data that has outlived its usefulness. 



In InfluxDB all points are written to measurements. A measurement may contain many series, and each series may contain many points. Each measurement belongs to a particular retention policy. Therefore a particular data point in InfluxDB belongs to a series, the series belongs to a measurement, the measurement belongs to a retention policy, and the retention policy belongs to a database. When writing a point the database and retention policy are also part of the write. If you do not supply an explicit retention policy with a write the point is written to the default retention policy.



Note: There is some confusing nomenclature regarding default retention policies. InfluxDB auto-generates a retention policy for each newly created database. That retention policy is called "default". However, using the 

## Continuous Queries

Setting up RPs, link to admin page
Setting up CQs, from raw to others. From others to others if raw retention not long enough. (#159)
CQ backreference (https://github.com/influxdb/influxdb/pull/3876)

Avoid overwriting points #140 (can we add an arbitrary tag to a point with a CQ?)
CQs only operate on new data, link to CQ page.

how to query different RPs (CLI cannot)
cannot query across RPs. 






mention this page on CQ page. 
mention this page on RP section.

mention CQ logging (#180)
other config options on CQ page (#127)


 I've assumed your database is named "mydb" and that you want each data point persisted in two nodes in the cluster.

CREATE RETENTION POLICY raw ON mydb DURATION 120m REPLICATION 2 DEFAULT
CREATE RETENTION POLICY one_min ON mydb DURATION 25h REPLICATION 2 
CREATE RETENTION POLICY five_min ON mydb DURATION 8d REPLICATION 2 
CREATE RETENTION POLICY thirty_min ON mydb DURATION 105w REPLICATION 2 

See https://influxdb.com/docs/v0.9/administration/administration.html#retention-policy-management for more on Retention Policies.

For the downsampling, I'm going to use an example measurement of "cpu_load" and assume there's only one field associated with it, named "value", but that there are many metadata tags (like "hostname", "az", "OS", ...). The "GROUP BY *" preserves each tag set independently when downsampling. I'll be using MEAN as the example function, but InfluxQL supports many others

CREATE CONTINUOUS QUERY raw_to_one_min BEGIN
     SELECT MEAN(value) INTO one_min.mean_cpu_load FROM raw.cpu_load GROUP BY time(1m), *
END

CREATE CONTINUOUS QUERY raw_to_five_min BEGIN
     SELECT MEAN(value) INTO five_min.mean_cpu_load FROM raw.cpu_load GROUP BY time(5m), *
END

CREATE CONTINUOUS QUERY raw_to_thirty_min BEGIN
     SELECT MEAN(value) INTO thirty_min.mean_cpu_load FROM raw.cpu_load GROUP BY time(30m), *
END

See https://influxdb.com/docs/v0.9/query_language/continuous_queries.html for more on Continuous Queries.

With 0.9.4 we will be adding a regex backreference operator (:measurement) to the continuous query declaration syntax, so that it becomes possible to do something like:

CREATE CONTINUOUS QUERY raw_to_one_min BEGIN
     SELECT MEAN(value) INTO one_min.mean_:measurement FROM raw./^cpu.*/ GROUP BY time(1m), *
END

That CQ would populate a 1 minute downsampled measurement in the "one_min" retention policy for every measurement in "raw" that starts with "cpu".
