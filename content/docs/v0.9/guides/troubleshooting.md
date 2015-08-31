---
title: Troubleshooting
---

This page addresses frequent sources of confusion and places where InfluxDB behaves in an unexpected way relative to other database systems. Where applicable, we link to outstanding issues on GitHub.

**Querying data**  

* [Getting unexpected results with `GROUP BY time()`](../guides/troubleshooting.html#getting-unexpected-results-with-group-by-time)  
* [Querying past `now()`](../guides/troubleshooting.html#querying-past-now)  
* [Querying outside the min/max time range](../guides/troubleshooting.html#querying-outside-the-min-max-time-range)  
* [Querying a time range that spans epoch 0](../guides/troubleshooting.html#querying-a-time-range-that-spans-epoch-0)  
* [Querying with booleans](../guides/troubleshooting.html#querying-with-booleans)  
* [Working with really big or really small integers](../guides/troubleshooting.html#working-with-really-big-or-really-small-integers) 
* [Doing math on timestamps](../guides/troubleshooting.html#doing-math-on-timestamps)  
* [Getting an unexpected epoch 0 timestamp in query returns](../guides/troubleshooting.html#getting-an-unexpected-epoch-0-timestamp-in-query-returns)  
* [Getting large query returns in batches](../guides/troubleshooting.html#getting-large-query-returns-in-batches)  
* [Identifying write precision from returned timestamps](../guides/troubleshooting.html#identifying-write-precision-from-returned-timestamps)  
* [Single quoting and double quoting in queries](../guides/troubleshooting.html#single-quoting-and-double-quoting-in-queries)  

**Writing data**  

* [Writing integers](../guides/troubleshooting.html#writing-integers)  
* [Writing data with negative timestamps](../guides/troubleshooting.html#writing-data-with-negative-timestamps)  
* [Words and characters to avoid](../guides/troubleshooting.html#words-and-characters-to-avoid)  
* [Single quoting and double quoting when writing data](../guides/troubleshooting.html#single-quoting-and-double-quoting-when-writing-data)  

**Authentication**  

* [Single quoting the password string](../guides/troubleshooting.html#single-quoting-the-password-string) 
* [Escaping the single quote in a password](../guides/troubleshooting.html#escaping-the-single-quote-in-a-password)  


# Querying data
## Getting unexpected results with `GROUP BY time()`
A query that includes a `GROUP BY time()` clause can yield unexpected results. In some cases, InfluxDB returns a single aggregated value with the timestamp `'1970-01-01T00:00:00Z'` even when the data include more than one instance of the time interval specified in `time()`. In other cases, InfluxDB returns `ERR: too many points in the group by interval. maybe you forgot to specify a where time clause?` even when the query already includes a `WHERE` time clause.

Those returns typically proceed from the combination of the following two features of InfluxDB:

* By default, InfluxDB uses epoch 0 (`1970-01-01T00:00:00Z`) as the lower bound and `now()` as the upper bound in queries. 
* A query that includes `GROUP BY time()` must cover fewer than 100,000 instances of the supplied time interval. 

If your `WHERE` time clause is simply `WHERE time < now()` InfluxDB queries the data back to epoch 0 - that behavior often causes the query to breach the 100,000 instances rule and InfluxDB returns a confusing error or result. Avoid perplexing `GROUP BY time()` returns by specifying a valid time interval in the `WHERE` clause.

<dt> [GitHub Issue 2977](https://github.com/influxdb/influxdb/issues/2977) </dt>

## Querying past `now()`
By default, `now()` (the current nanosecond timestamp of the node that is processing the query) is the upper bound for queries in InfluxDB. To query points that occur in the future you must provide explicit directions in the `WHERE` clause. 

The first query below asks InfluxDB to return everything from `hillvalley` that occurs between epoch 0 (`1970-01-01T00:00:00Z`) and `now()`. The second query asks InfluxDB to return everything from `hillvalley` that occurs between epoch 0 and 1,000 days from `now()`.

`SELECT * FROM hillvalley`  
`SELECT * FROM hillvalley WHERE time < now() + 1000d`

## Querying outside the min/max time range 
Queries with a time range that exceeds the minimum or maximum timestamps valid for InfluxDB currently return no results, rather than an error message.

Smallest valid timestamp: `-9023372036854775808` (approximately `1684-01-22T14:50:02Z`)  
Largest valid timestamp: `9023372036854775807` (approximately `2255-12-09T23:13:56Z`)

<dt> [GitHub Issue #3369](https://github.com/influxdb/influxdb/issues/3369)  </dt>

## Querying a time range that spans epoch 0
Currently, InfluxDB can return results for queries that cover either the time range before epoch 0 or the time range after epoch 0, not both. A query with a time range that spans epoch 0 returns partial results. 

Note that InfluxDB has supported negative timestamps (timestamps that occur before epoch 0) in the past, but users should be aware of a bug when attempting to [write data with negative timestamps](../guides/troubleshooting.html#writing-data-with-negative-timestamps).

<dt> [GitHub Issue #2703](https://github.com/influxdb/influxdb/issues/2703)  </dt>

## Querying with booleans
Acceptable boolean syntax differs for data writes and data queries.

| Boolean syntax |  Writes | Queries  |
-----------------------|-----------|--------------|
|  `t`,`f` |	✔️ | ❌ |
|  `T`,`F` |  ✔️ |  ❌ |
|  `true`,`false` | ✔️  | ✔️  |
|  `True`,`False` |  ✔️ |  ✔️ |
|  `TRUE`,`FALSE` |  ✔️ |  ✔️ |

For example, `SELECT ... WHERE tag1=True` returns all points with `tag1` set to `TRUE`, but `SELECT ... WHERE tag1=T` returns an empty set of points and no error. 

****CHECK THIS? I'M GETTING T, t give returns in a query and F,f give falses****

## Working with really big or really small integers
InfluxDB stores all integers as signed `int64` data types. The minimum and maximum valid values for `int64` are `-9023372036854775808` and `9023372036854775807`. See [Go builtins](http://golang.org/pkg/builtin/#int64) for more information. 

Values close to but within those limits may lead to unexpected results, as some functions and operators convert the `int64` data type to `float64` during calculation, causing overflow issues.

<dt> [GitHub Issue #3130](https://github.com/influxdb/influxdb/issues/3130)  </dt>

## Doing math on timestamps
Currently, it is not possible to execute mathematical operators or functions against timestamp values. All time calculations must be carried out by the client receiving the InfluxDB query results.

## Getting an unexpected epoch 0 timestamp in query returns
In InfluxDB, epoch 0  (`1970-01-01T00:00:00Z`)  is often used as a null timestamp equivalent. If you request a query that has no timestamp to return, such as an aggregation function with an unbounded time range, InfluxDB returns epoch 0 as the timestamp. 

<dt> [GitHub Issue #3337](https://github.com/influxdb/influxdb/issues/3337) </dt>

## Getting large query returns in batches
Large query results are returned in batches of 10,000 points unless you use the query string parameter `chunk_size` to explicitly set the batch size.  For example, get results in batches of 20,000 points with:

`curl -G 'http://localhost:8086/query' --data-urlencode "db=deluge" --data-urlencode "chunk_size=20000" --data-urlencode "q=SELECT * FROM liters"`

<dt> See [GitHub Issue #3242](https://github.com/influxdb/influxdb/issues/3242) for more information on the challenges this can cause, especially with Grafana visualization. </dt>

## Identifying write precision from returned timestamps
InfluxDB stores all timestamps as nanosecond values regardless of the write precision supplied. It is important to note that when returning query results, the database silently drops trailing zeros from timestamps which obscures the initial write precision. 

In the example below, the tags `precision_supplied` and `timestamp_supplied` show the time precision and timestamp that the user provided at the write. Because InfluxDB silently drops trailing zeros on returned timestamps, the write precision is not recognizable in the returned timestamps.

```sh
name: trails
-------------
time                  value	 precision_supplied  timestamp_supplied
1970-01-01T01:00:00Z  3      n                   3600000000000
1970-01-01T01:00:00Z  5      h                   1
1970-01-01T02:00:00Z  4      n                   7200000000000
1970-01-01T02:00:00Z  6      h                   2
```

<dt> [GitHub Issue #2977](https://github.com/influxdb/influxdb/issues/2977) </dt>

## Single quoting and double quoting in queries
Single quote string values (for example, tag-values) but do not single quote identifiers (database names, retention policy names, user names, measurement names, tag keys, and field keys). 

Double quote identifiers if they start with a digit or contain characters other than `[a-z]`, `[A-Z]`, `[0-9]`, or `_`. You can double quote identifiers even if they don't contain special characters but it isn't necessary.

Yes: `SELECT bikes_available FROM bikes WHERE station_id='9'`

Yes: `SELECT "bikes_available" FROM "bikes" WHERE "station_id"='9'`

Yes: `SELECT * from "cr@zy" where "p^e"='2'`

No: `SELECT 'bikes_available' FROM 'bikes' WHERE 'station_id'="9"`

No: `SELECT * from cr@zy where p^e='2'`

See the [Query Syntax](../query_language/query_syntax.html) page for more information.

# Writing data
## Writing integers
Add a trailing `i` to the end of the field-value when writing an integer. If you do not provide the `i`, InfluxDB will treat the field-value as a float. 

Integer: `response_time,host=server1 value=100i`  
Float: `response_time,host=server1 value=100` 

## Writing data with negative timestamps
InfluxDB has supported negative UNIX timestamps in the past, but there is currently a bug in the line protocol parser that treats negative timestamps as invalid syntax. For example, `insert waybackwhen past=1 -1` returns `ERR: unable to parse 'waybackwhen past=1 -1': bad timestamp`.

<dt> [GitHub Issue #3367](https://github.com/influxdb/influxdb/issues/3367) </dt>

## Words and characters to avoid
If you use any of the [InfluxQL Reserved Words](https://github.com/influxdb/influxdb/blob/master/influxql/INFLUXQL.md#keywords) as an identifier or string in your schema you will need to double quote that identifier or string in every query. This can lead to non-intuitive errors and is not recommended.

To keep regular expressions simple, avoid using the following characters in identifiers and strings: backslash: `\`; up-carat: `^`; dollar-sign: `$`.

## Single quoting and double quoting when writing data
Never use single quotes when writing data via the line protocol. Double quote field-values that are strings but do not double quote identifiers (database names, retention policy names, user names, measurement names, tag keys, and field keys). Special characters should be escaped with a backslash and not placed in quotes. 

Yes: `insert bikes,station_id=2 bikes_available=3`

Yes: `insert bikes,station_id=2 happiness="level 2"`

No: `insert "bikes","station_id"=2 "happiness"='level 2'`

See the [Line Protocol Syntax](https://influxdb.com/docs/v0.9/write_protocols/write_syntax.html) page for more information.

# Authentication
## Single quoting the password string 
The `CREATE USER <user> WITH PASSWORD '<password>'` query requires single quotation marks around the password string. Do not include the single quotes when authenticating requests.

## Escaping the single quote in a password
For passwords that include a single quote, escape the single quote with a backslash both when creating the password and when authenticating requests.






