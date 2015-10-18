---
title: Continuous Queries in InfluxDB - Part I
author: Todd Persen
date: 2015-10-21
publishdate: 2015-10-21
---

Queries returning aggregate, summary, and computed data are frequently used in application development. For example, if you’re building an online dashboard application to report metrics, you probably need to show summary data. These summary queries are generally expensive to compute since they have to process large amounts of data, and running them over and over again just wouldn't scale. Now, if you could pre-compute and store the aggregates query results so that they are ready when you need them, it would significantly speed up summary queries in your dashboard application, without overloading your database. Enter InfluxDB’s [continuous queries](https://influxdb.com/docs/v0.9/query_language/continuous_queries.html) feature!

This is the first in a three-part series that will you understand continuous queries in InfluxDB. In this post, we will cover the basics on what continuous queries are and their use cases. In part two, we will go under-the-hood to learn about how continuous queries work, and finally in part three, we will explain how to monitor and manage continuous queries. 

So, let’s get started.

## Introducing continuous queries in InfluxDB

If you come from an RDBMS background, continuous queries are conceptually very similar to materialized views, where expensive query results are pre-computed and stored, instead of being computed on-the-fly. Continuous queries in InfluxDB are powerful and useful for several different use-cases, mainly around improving the experience around data analysis as described below.

### Viewing data efficiently with continuous queries

In a dashboard application, metric data is typically presented in the form of graphs. Typically, these metrics are downsampled before they are displayed. This means that, they are either  aggregated around a particular time interval or simply the Nth data point is picked in the metric series. 

With continuous queries in InfluxDB, you can downsample application data and improve the end user experience for your users.  For example, as shown in the figure below, the input graph is downsampled, and the output captures every 10th point in the input graph. 

![Continuous Query Downsampling](/img/blog/downsample.png)

For example, using the continuous query described below, InfluxDB downsamples the CPU load metric, and keeps a single average datapoint per 15 minutes grouped by server region.

```
CREATE CONTINUOUS QUERY "downsampled_cpu_load"
ON database_name
BEGIN
  SELECT mean(value) as value,
  INTO "downsampled.cpu_load"
  FROM cpu_load
  GROUP BY time(15m), region
END
```

High resolution data is great when you are detecting problems and resolving issues in the present or recent past, but as the data ages, and you don’t need that level of detail, you can use continuous queries to downsample and reduce data resolution (either daily or weekly).

### Analysing data efficiently with continuous queries

In addition to downsampling data, continuous queries can transform and isolate data from one series into one or more other dependent series for more efficient access. They are also useful when you want to &ldquo;rollup&rdquo; time-series data by time period (e.g., get the 99th percentile service times across 5, 10 and 15 minute periods).

For example, imagine that you are capturing incoming HTTP requests to your web server as the http_requests series, and want to calculate the 95th percentile and mean duration of your incoming requests, over the series that you’ve already collected. You can solve this using a continuous query below - 

```
CREATE CONTINUOUS QUERY "transformed_http_requests"
ON database_name
BEGIN
  SELECT mean(duration) as mean,
	  PERCENTILE(duration, 95.0) as p95
  FROM http_requests
  GROUP BY time(15m), http_status
END
```

In the next example below, a regular expression can be used in the `FROM` clause of a continuous query to collect points selected from all measurements and write them into  the `policy1` retention policy with the same measurement names. 

```
CREATE CONTINUOUS QUERY myquery ON testdb 
	BEGIN 
   		SELECT mean(value) INTO "policy1".:MEASUREMENT 
FROM /.*/ 
GROUP BY time(1h) 
END
```

## Using continuous queries in your application

To begin using continuous queries, you need to create a continuous query on the server. Continuous queries in InfluxDB can be created by running the `CREATE CONTINUOUS QUERY` statement against the query endpoint of the server. 

Using curl, you can create a continuous query in InfluxDB with the following:

```
curl -G 'http://localhost:8086/query' --data-urlencode 'q=CREATE CONTINUOUS QUERY ...'
```

Once created, continuous queries are persisted as part of the metadata for the cluster and they run periodically as data is collected. 

## New continuous query engine

InfluxDB v0.9 had some major architectural changes around retention, clustering, and the InfluxQL language. As a result, the continuous query engine had to be re-designed, and the rewrite in v0.9 introduced couple of changes compared to the previous version (v0.8). These changes are captured in the table below.

<table>
    <tr><th>Feature</th><th>v0.8.8</th><th>v0.9.4 (Latest)</th></tr>
    <tr><td>Fan-out queries</td><td>Yes</td><td>No</td></tr>
    <tr><td>Backfilling</td><td>Yes</td><td>No</td></tr>
</table>

## Conclusion 

In today’s post, we’ve only scratched the surface of continuous queries. To learn more about how continuous queries work under the hood, or how to manage continuous queries, stay tuned for part two and part three of continuous queries in InfluxDB. 

Until then, we hope you [sign up for a free 14-day trial of hosted InfluxDB](https://customers.influxdb.com/) and get started!

![Grafana](/img/blog/grafana_preview.png)
