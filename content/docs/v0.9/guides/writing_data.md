---
title: Writing Data
aliases:
  - /docs/v0.9/concepts/reading_and_writing_data.html
---

There are many ways to write data into InfluxDB including [client libraries](../clients/api.html) and integrations with external data sources such as [Graphite](/write_protocols/graphite.html). Here we'll show you how to write data using the built-in HTTP API.

## Writing data using the HTTP API
The HTTP API is the primary means of putting data into InfluxDB. To write data simply send a `POST` to the endpoint `/write`. You must specify the destination database as a query parameter and include in the body of the POST the time-series data that you wish to store. 

Create the database `mydb` with the following:

```sh
curl -G http://localhost:8086/query --data-urlencode "q=CREATE DATABASE mydb"
```
The example below sends a request to InfluxDB running on localhost and writes a single point to the database `mydb`. The data consist of the [measurement](../concepts/glossary.html#measurement) `cpu_load_short`, the [tag-keys](../concepts/glossary.html#tag-key) `host` and `region`, the [tag-values](../concepts/glossary.html#tag-value) `server01` and `us-west`, the [field-key](../concepts/glossary.html#field-key) `value`, the [field-value](../concepts/glossary.html#field-value) `0.64`, and the [timestamp](../concepts/glossary.html#timestamp) `1434055562000000000`.

```sh
curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'
```
When writing points, you must specify the database query parameter `db` in the request body and the database must already exist. Writes also require a measurement name and field. Field-keys are always strings and, by default, field-values are floats. For other field-value type options, see the [field-value](../concepts/glossary.html#field-value) entry in the Glossary. 

Strictly speaking, tags are optional but most series include tags to differentiate data sources and to make querying both easy and efficient. Both tag-keys and tag-values must be strings. The timestamp - supplied as an integer at the end of the line - is also optional. If you do not specify a timestamp InfluxDB uses the server's local nanosecond timestamp in Unix epoch. Anything that has to do with time in InfluxDB is always UTC. It is possible to configure the precision of the timestamp by including the `precision` url parameter. Check out the [HTTP write syntax](../write_protocols/write_syntax.html#http) for more on timestamp precisions. 

Another optional query parameter that isn't included in the example above is the retention policy query parameter `rp`. The retention policy describes how long the data are kept. If you do not specify a retention policy with `rp` the point's retention policy is the same as the database's default retention policy. For a complete discussion of retention policies and other available query parameters, see the [HTTP write syntax](../write_protocols/write_syntax.html#http).

### Writing multiple points
Post multiple points to multiple series at the same time by separating each point with a new line. Batching points in this manner results in much higher performance.

The following example writes three points to the database `mydb`. The first point is written to the series with the measurement `cpu_load_short` and tag set `host=server02` and has the server's local timestamp. The second point is written to the series with the measurement `cpu_load_short` and tag set `host=server02,region=us-west` and has the specified timestamp `1422568543702900257`. The third point has the same specified timestamp as the second point, but it is written to the series with the measurement `cpu_load_short` and tag set `direction=in,host=server01,region=us-west`.

```sh
curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary 'cpu_load_short,host=server02 value=0.67
cpu_load_short,host=server02,region=us-west value=0.55 1422568543702900257
cpu_load_short,direction=in,host=server01,region=us-west value=23422.0 1422568543702900257'
```
### Schemaless Design
InfluxDB is schemaless so the series and fields get created on the fly. You can add fields to existing series without penalty. Note that if you attempt to write data with a different type than previously used (for example, writing a string to a field that previously accepted integers), InfluxDB will reject those data.

### Responses
* 2xx: If it's `HTTP 204 No Content`, success! If it's  `HTTP 200 OK`, InfluxDB understood the request but couldn't complete it. The body of the response will contain additional error information.
* 4xx: InfluxDB could not understand the request.
* 5xx: The `influxd` process is either down or significantly impaired.

**Examples of error responses:**

* Writing a float to a field that previously accepted booleans:

```sh
curl -i -XPOST 'http://localhost:8086/write?db=hamlet' --data-binary 'tobeornottobe booleanonly=5'
```

gives you:

```sh
HTTP/1.1 400 Bad Request
[...]
write failed: field type conflict: input field "booleanonly" on measurement "tobeornottobe" is type float64, already exists as type boolean
```

* Writing a point to database that doesn't exist:

```sh
curl -i -XPOST 'http://localhost:8086/write?db=atlantis' --data-binary 'liters value=10'
```
gives you:

```sh
HTTP/1.1 404 Not Found
[...]
database not found: "atlantis"
```
###Next up

Now that you know how to write data with the built-in HTTP API discover how to query them with the [Querying Data](../guides/querying_data.html) guide!

