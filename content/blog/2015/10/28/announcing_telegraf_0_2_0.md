---
title: Announcing Telegraf 0.2.0 with StatsD, MQTT, and Improved Scalability
author: Cameron Sparr
date: 2015-10-28
publishdate: 2015-10-28
---

We are excited to announce that [Telegraf 0.2.0](https://github.com/influxdb/telegraf), InfluxDB’s native, open source data collecting
agent, is now available!

## What’s New

- [PR #205](https://github.com/influxdb/telegraf/pull/205): Include per-db redis keyspace info
- [PR #241](https://github.com/influxdb/telegraf/pull/241): MQTT Output. thanks [@shirou](https://github.com/shirou)!
- [PR #240](https://github.com/influxdb/telegraf/pull/240): procstat plugin, thanks [@ranjib](https://github.com/ranjib)!
- [PR #244](https://github.com/influxdb/telegraf/pull/244): netstat plugin, thanks [@shirou](https://github.com/shirou)!
- [PR #262](https://github.com/influxdb/telegraf/pull/262): zookeeper plugin, thanks [@jrxFive](https://github.com/jrxFive)!
- [PR #237](https://github.com/influxdb/telegraf/pull/237): statsd service plugin, thanks [@sparrc](https://github.com/sparrc)
- [PR #273](https://github.com/influxdb/telegraf/pull/273): puppet agent plugin, thanks [@jrxFive](https://github.com/jrxFive)!
- [PR #286](https://github.com/influxdb/telegraf/pull/286): bcache plugin, thanks [@cornerot](https://github.com/cornerot)!
- [PR #287](https://github.com/influxdb/telegraf/pull/287): Batch AMQP output, thanks [@ekini](https://github.com/ekini)!
- [PR #301](https://github.com/influxdb/telegraf/pull/301): Collect on even intervals
- [PR #300](https://github.com/influxdb/telegraf/pull/300): aerospike plugin. thanks [@oldmantaiter](https://github.com/oldmantaiter)!
- [PR #322](https://github.com/influxdb/telegraf/pull/322): Librato output. thanks [@jipperinbham](https://github.com/jipperinbham)!

## Release Notes

- The `-test` flag will now only output 2 collections for plugins that need it.
- There is a new agent configuration option: `flush_interval`. This option tells Telegraf how often to flush data to InfluxDB and other output sinks. For example, users can set `interval = "2s"` and `flush_interval = "60s"` for Telegraf to collect data every 2 seconds and flush every 60 seconds.
- `precision` and `utc` are no longer valid agent config values. `precision` has moved to the InfluxDB output config, where it will continue to default to `s`
- Debug and test output will now print the raw line-protocol string.
- Telegraf will now, by default, round the collection interval to the nearest
even interval. This means that `interval="10s"` will collect every :00, :10, etc.
- To ease scale concerns, flushing will be "jittered" by a random amount so that
all Telegraf instances do not flush at the same time. Both of these options can
be controlled via the `round_interval` and `flush_jitter` config options.
- Telegraf will now retry metric flushes twice.

## Get your InfluxDB hoodie while they last!

Does your company have a cool app or product that uses InfluxDB in production? We’d love to feature it on influxdb.com and give you a shout out on social media. As a “thank you” gift, we’ll send you an InfluxDB hoodie and a pack of stickers. Just [fill out this simple form](https://influxdb.com/testimonials/) and we’ll let you know when your entry is live and the hoodie is in the mail. Drop us a line at contact@influxdb.com if you have any questions. Thanks for the support!
