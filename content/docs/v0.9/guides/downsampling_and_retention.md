---
title: Downsampling and Data Retention
---

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
