---
title: Getting Started with Influx StatsD
author: Cameron Sparr
date: 2015-11-03
publishdate: 2015-11-03
---

This tutorial will walk you through sending
[StatsD](https://github.com/etsy/statsd#statsd-)
metrics to [Telegraf.](https://github.com/influxdb/telegraf/)

[StatsD](https://github.com/etsy/statsd#statsd-)
is a simple protocol for sending application metrics via UDP. These metrics
can be sent to a Telegraf instance, where they are aggregated and eventually
flushed to [InfluxDB](https://influxdb.com/)
or other output sinks that you have configured.

## Why StatsD?

There are many good reasons to use StatsD, and [many](https://www.datadoghq.com/blog/statsd/)
[good](https://codeascraft.com/2011/02/15/measure-anything-measure-everything/)
[blogs](https://www.digitalocean.com/community/tutorials/an-introduction-to-tracking-statistics-with-graphite-statsd-and-collectd)
about why it's great. StatsD is simple, has a tiny footprint, and has a
fantastic ecosystem of client libraries. It can't crash your application and has
become the standard for large-scale metric collection.

## How it Works

[Telegraf](https://github.com/influxdb/telegraf/) is an agent written
in Go and accepts StatsD protocol metrics over UDP, then periodically
forwards the metrics to InfluxDB.

[StatsD](https://github.com/etsy/statsd#statsd-)
metrics can be sent from applications using any of the many available
[client libraries.](https://github.com/etsy/statsd/wiki#client-implementations)
Here is a standard setup for collecting StatsD metrics:

![Influx StatsD](/img/blog/InfluxStatsD.svg)

## Why UDP?

UDP is often called the "fire and forget" protocol. UDP does not wait for a
response, meaning that your application can continue
doing it's work regardless of the status of the StatsD server. Additionally, it
is connection-less, so there is very little overhead introduced into your app.

## Setup

First, you need to have
[Telegraf installed](https://github.com/influxdb/telegraf#installation). Here
I'll just download the standalone linux binary:

```bash
$ wget http://get.influxdb.org/telegraf/telegraf_linux_amd64_0.2.0.tar.gz
$ tar -xvf telegraf_linux_amd64_0.2.0.tar.gz
$ mv telegraf_linux_amd64 /usr/bin/telegraf && chmod +x /usr/bin/telegraf
```

Next, you will need to setup Telegraf with the `statsd` plugin. The
`-sample-config` option tells Telegraf to output a config file. `-filter` and
`-output-filter` tell Telegraf which plugins (StatsD) and outputs (InfluxDB)
to configure:

```bash
$ telegraf -sample-config -filter statsd -outputfilter influxdb > tele.conf
$ telegraf -config tele.conf
```

The config file (`tele.conf`) will assume that your InfluxDB instance is
running on `localhost`, and will need to be edited if that's not the case. There
are also many configuration options for the StatsD server, but I won't go into
all of them in this guide, see the
[documentation](https://github.com/influxdb/telegraf/blob/master/plugins/statsd/README.md)
for more details.

## Sending StatsD Metrics

By default, Telegraf will begin listening on port 8125 for UDP packets. StatsD
metrics can be sent to it using echo and netcat:

```bash
$ echo "mycounter:10|c" | nc -C -w 1 -u localhost 8125
```

Or using your
[favorite client library.](https://github.com/etsy/statsd/wiki#client-implementations)

## Introducing Influx StatsD

Since InfluxDB supports tags, our StatsD implementation does too! Adding tags
to a StatsD metric is similar to how they appear in
[line-protocol.](https://influxdb.com/docs/v0.9/write_protocols/line.html)

This means that you can tag your StatsD metrics like below. This particular
metric increments the `user_login` counter by 1, with tags for the service
and region we are using.

```
user.logins,service=payroll,region=us-west:1|c
```

That's it! Simply add a comma-separated list of tags in key=value format.

For those of you using a StatsD client, this extra bit can be added to the
the bucket. I'll use the [Python client](https://pypi.python.org/pypi/statsd)
as an example:

```python
>>> import statsd
>>> c = statsd.StatsClient('localhost', 8125)
>>> c.incr('user.logins,service=payroll,region=us-west')  # Increment counter
```

Once flushed, the metric will be available in InfluxDB in all its tagged
glory.

```text
> SELECT * FROM statsd_user_logins
name: statsd_user_logins
------------------------
time                    host    metric_type  region   service  value
2015-10-27T03:26:40Z    tyrion  counter      us-west  payroll  1
2015-10-27T03:26:50Z    tyrion  counter      us-west  payroll  1
```

## Metrics

Telegraf supports all of the standard
[StatsD metrics,](https://github.com/etsy/statsd/blob/master/docs/metric_types.md)
which are detailed below.

### Counters

```text
logins.total:1|c
logins.total:15|c
```

A simple counter, the `logins_total` metric will be incremented by 1 and 15 in
the above examples. Counters can be always-increasing, or you can opt to have them
cleared with each flush using the `delete_counters` config option.

#### Sampling

```text
logins.total:1|c|@0.1
```

Tells StatsD that this counter is being sent sampled every 1/10th of the time.
In this example, the `logins_total` metric will be incremented by 10.

### Gauges

```text
current.users:105|g
```

Gauges are changed with each subsequent value sent. The value that makes it to
InfluxDB will be the last recorded value. Gauges will remain at the same value
until a new value is sent. You can opt to have them cleared with each flush using
the `delete_gauges` config option.

Adding a sign can change the value of a gauge rather than overwriting it:

```text
current.users:-10|g
current.users:+12|g
```

### Timings & Histograms

```text
response.time:301|ms
response.time:301|h
```

Timings are meant to track how long something took. They are an invaluable tool
for tracking application performance.

When Telegraf receives timing metrics, it will aggregate them and write the
following statistics to InfluxDB, more details on each of these can be found in
the
[documentation](https://github.com/influxdb/telegraf/tree/master/plugins/statsd#measurements)

* `stat_name`_lower
* `stat_name`_upper
* `stat_name`_mean
* `stat_name`_stddev
* `stat_name`_count
* `stat_name`_percentile_90

#### Sampling

```text
response.time:301|ms|@0.1
```

Timings, like counters, can also be sampled. This will let Telegraf know that
this timing was only taken once every 10 runs.

### Notes

Telegraf aggregates stats as they arrive, and limits the number of timings cached
to keep it's memory footprint low. By default, Telegraf will keep track of 1000
timings per-stat when calculating percentiles. This can be adjusted using the
`percentile_limit` config option.

### Sets

```text
unique.users:100|s
```

Sets can be used to count unique occurences. In the above example, the
`unique.users` metric will be incremented by 1, then will not be incremented no
matterhow many times the value `100` is sent.

## Future Work

In the coming months, we plan to support additional extensions of the
standard StatsD protocol, including the ability to specify multiple fields within a
measurement. This will come after InfluxDB 0.9.5 ships, where multiple fields
will
[have no performance hit.](https://influxdb.com/blog/2015/10/07/the_new_influxdb_storage_engine_a_time_structured_merge_tree.html)

Also, let us know what you'd like to see by
[opening an issue on github](https://github.com/influxdb/telegraf/issues)!

------

[Cameron Sparr](https://github.com/sparrc) works for InfluxDB and is the
maintainer of [Telegraf](https://github.com/influxdb/telegraf)
