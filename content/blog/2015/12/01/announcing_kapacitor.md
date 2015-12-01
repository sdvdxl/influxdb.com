---
title: Announcing Kapacitor, an open source streaming and batch time series processor
author: Nathaniel Cook
date: 2015-12-01
publishdate: 2015-12-01
---

Today we are happy to announce [Kapacitor](https://influxdb.com/docs/kapacitor/v0.1/introduction/index.html) an [open source](https://github.com/influxdb/kapacitor) 
data processing engine for time series data written in Go.
Kapacitor enables you to:

* trigger alerts based on complex and dynamic criteria,
* run ETL jobs on current and historical data,
* and process data in real time or in batches.

For a simple walk through check out this quick video, or continue reading.

<iframe src="https://player.vimeo.com/video/147392332" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
<div></div>

### What is Kapacitor?
**If you can't wait [get started now](https://influxdb.com/docs/kapacitor/v0.1/introduction/getting_started.html)!**

Kapacitor is a standalone program that processes time series data.
Data can be streamed or sent in scheduled batches to Kapacitor via any number of inputs, including InfluxDB.
Kapacitor can even subscribe to receive all data sent to an InfluxDB cluster.

Right now Kapacitor can process your data using the same functions available in the InfluxDB query language (i.e. sum, min, max, stddev, etc).
We plan to add more features soon namely: more aggregation functions, custom user defined functions and anomaly detection.

Many of you have been asking for a tool like Kapacitor for a while now and we have done our best to fulfill that need.
With this release we are looking for early feedback on how Kapacitor fits your needs and what we can do to improve it.
We also want Kapacitor to able to integrate with third-party applications.
If you already have something in mind, check out [this](/docs/kapacitor/v0.1/contributing/custom_output.html) guide on how to contribute your own custom output connector to Kapacitor.
Output connectors let you stream transformed data and alerts to other data stores or third party APIs.

### How do you use Kapacitor?

Kapacitor runs tasks that are defined via a DSL named [TICKscript](https://influxdb.com/docs/kapacitor/v0.1/tick/index.html).
TICKscripts define what and how data is processed in Kapacitor.
The TICKscript below is a *Hello World* task in Kapacitor that trigger alerts on high cpu usage.

```javascript
stream
    .from().measurement('cpu')
    .alert()
        .crit(lambda: "value" > 80.0)
        .log('/tmp/high_cpu.log')
```
With that simple script you are up and running and can trigger alerts based on cpu usage.

For a more complete example, let's say you are a game developer and need to build a dashboard of top player scores for spectators.
With Kapacitor you can define a task that will do the heavy lifting of keeping an up-to-date set of player scores for each game.
All you would have to do is send score updates to Kapacitor and configure the dashboard to pull its data from Kapacitor.
The TICKscript below gets the most recent score per player and then calculates the top five players per game.

```javascript
stream
    // Select data from the 'scores' stream
    .from().measurement('scores')
    // Get the most recent score for each player per game
    .groupBy('game', 'player')
    .window()
        .period(10s)
        .every(1s)
        .align()
    .mapReduce(influxql.last('value'))
    // Calculate the top 5 scores per game
    .groupBy('game')
    .mapReduce(influxql.top(5, 'last', 'player'))
    // Expose those scores over the HTTP API at the 'top_scores' endpoint.
    // Now the leaderboard can just request the top scores from Kapacitor
    // and always get the most recent results.
    .httpOut('top_scores')
```

See a full explanation on how this particular example works [here](/docs/kapacitor/v0.1/examples/live_leaderboard.html).

The [Getting Started](/docs/kapacitor/v0.1/introduction/getting_started.html) guide will walk you through to first steps of using Kapacitor.
Let us know what you think! Use the [mailing list](https://groups.google.com/forum/#!forum/influxdb) or submit and issue or better yet a PR on [github](https://github.com/influxdb/kapacitor).
