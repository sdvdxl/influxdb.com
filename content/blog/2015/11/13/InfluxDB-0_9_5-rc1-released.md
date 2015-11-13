---
title: InfluxDB 0.9.5-rc1 released 
author: Paul Dix
date: 2015-11-13
publishdate: 2015-11-13
---

Today we're releasing InfluxDB v0.9.5-rc1. For the last 4 weeks, we were blocking this release based on finishing our work on the new [Time Strucutred Merge Tree storage engine](/blog/2015/10/07/the_new_influxdb_storage_engine_a_time_structured_merge_tree.html). While the work on TSM isn't completed yet (and thus not included in this release), there are 32 features and 75 bug fixes in the change log waiting for a release. We decided that it would be best to release these improvements for our current users and keep TSM in the development stages. Read on for more details on what's in this release and what it means for you, the current state of the new storage engine, future work on clustering and the query engine, and our release cadence for the next 6 months.

### What's new in this release?

This release has 32 features and 75 bug fixes. Many of the bug fixes are related to clustering, hinted hand-off, and other stability improvements. There were a number of bugs that would panic and crash the server that have been resolved.

On the feature side of things, we've added functionality to drop servers (both Raft and non-raft) which is necessary for any node that leaves the cluster and isn't coming back. Another big feature is the addition of a `SUBSCRIBE` query to have all data coming into InfluxDB sent to another service via UDP. You can read see the [details about subscribe here](https://github.com/influxdb/influxdb/pull/4375).

We've also reverted this release to be built with Go 1.4.3. We had a few issues pop up that we suspect are related to Go 1.5.1, which are slated to be fixed in 1.5.2. Given that we have enough happening in our own code base at this point, we figured it would be prudent to pull back to an earlier version of Go. Some of the issues: [#4548](https://github.com/influxdb/influxdb/issues/4548), [#4554](https://github.com/influxdb/influxdb/issues/4554).

### What this release means for you

If you're currently running a version 0f 0.9, you should probably upgrade. If you're one of the users with higher write throughput that is waiting for the new storage engine, sit tight and wait for the next nightly build that is ready for additional testing. We'll make an announcement on this blog to let you know that we're ready for another round of testing on the TSM engine.

If you're a user of 0.8 looking to upgrade, you could do so if your throughput is on the low end, or you may want to wait until the first version that has the TSM storage engine ready. From an API standpoint, we've been stable since 0.9.3 and have no breaking changes planned so you can start work on the migration path with this release.

### The current state of the new storage engine

Thanks to many users in the community we were able to find a number of bugs and issues that need to be addressed in the TSM engine. We're in the process of modifying the underlying file format a little bit along with how compactions and the WAL work. The concepts remain the same so the write and compression characteristics will remain the same.

On the downside this means that it isn't ready for the 0.9.5 release. However, on the upside it means that we're reworking and building towards an even more solid foundation from which to move forward. We didn't want to release TSM as the default engine until it's ready. We'll update as soon as this round of refactoring is done and in a nightly build so that everyone that's interested can test the latest builds.

### Future work on clustering and the query engine

We're reworking the query engine to support more advanced query functionality. This means joining series together and doing math against them, aggregations on moving windows of time, selecting tag data along with individual data points and much more. Query performance is another key consideration with this work.

Another big part of the effort is to produce a clear structure in the code around the different concepts in query functionality, which will enable contributors in the community to quickly and easily add new query functionality. Our goal with this is to enable the community to contribute many new functions like they have with [Telegraf Plugins](https://github.com/influxdb/telegraf/blob/master/CONTRIBUTING.md).

On the clustering side of things, we're continuing improvements there with each release. Still left over is work to copy shards from one server to another (blocking on TSM), active anti-entropy (to ensure eventual consistency), and general stability and performance improvements.

### The InfluxDB release cadence

After this release, we'll be falling into a predictable release cadence. This means that we'll cut releases and whatever features are ready for production will make it in while others will be held back for more development and included in some future release. The 0.9.6 release will be on December 8th. The 0.9.7 release will be at the end of January. We'll do our best to keep you updated on how things are progressing and what's in the new releases.

Releases after 0.9.7 will be on a 2 month cycle. Every 2 months we'll cut a new release. The plan for the moment is to use 4 weeks of that on feature development and bug fixing, 2 weeks on dedicated to bug fix and testing, and the final 2 weeks in which we'll be in code freeze and testing the RC (which will be released 6 weeks into the cycle).

### Want to give it a try?

You can <a href="https://influxdb.com/download/" target="_">download InfluxDB</a> or sign up for a <a href="https://customers.influxdb.com/" target="_">free trial of a manged InfluxDB server</a> in the cloud. The managed hosting platform is still running 0.9.4.2, but will be upgraded to 0.9.5 on release.

We also offer expert professional services for help with InfluxDB, feature requests, performance tuning, and advanced configurations. Contact us at [contact@influxdb.com](mailto:support@influxdb.com) to learn more about how we can help accelerate your project.
