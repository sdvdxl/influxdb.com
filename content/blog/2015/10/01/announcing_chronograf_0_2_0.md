---
title: Announcing Chronograf 0.2.0 with Embedded Graphs, Custom Time Ranges, and More!
author: Todd Persen
date: 2015-10-01
publishdate: 2015-10-01
---

The first release of Chronograf happened just under 3 months ago, and we're proud to announce today that we're releasing a new version, [v0.2.0](https://influxdb.com/chronograf/index.html).

![Chronograf v0.2.0](/img/blog/chronograf_0.2.0/1.png)

The Chronograf team has done a ton of work since that first release, all in order to make a great visualization experience for InfluxDB. Below, I'll outline some of the most significant changes.

## Embedding graphs in iframes

![Share and Embed](/img/blog/chronograf_0.2.0/2.png)

Through Chronograf's sharing interface, you can now grab a code snippet to embed a graph using an iframe. This was a heavily requested feature, and makes it easy to quickly design a graph and insert it into an existing web page.

## Support multiple InfluxDB instances

![Share and Embed](/img/blog/chronograf_0.2.0/3.png)

In this release, Chronograf has gained a servers pane, where you can add multiple InfluxDB servers, manage their settings, and control authentication settings on a per-server basis.

Additionally, you can now specify a server, database, and retention policy on each query, allowing you to build a single graph with data from disparate sources.

![Share and Embed](/img/blog/chronograf_0.2.0/4.png)

## Custom time ranges

![Custom Time Ranges](/img/blog/chronograf_0.2.0/5.png)

Another powerful data exploration feature is the ability to define custom time ranges for your graphs. The previous version of Chronograf only allowed you to view data for fixed intervals, which obviously doesn't cover all use cases.

## Persistence and configuration

Chronograf now has a persistence layer built in, which will use either a local database format or a configurable MySQL database. This is configurable through a [new TOML file](https://github.com/influxdb/chronograf/blob/master/main.go#L135) that will be expanded in the future.

## Native build for OSX

Chronograf v0.1.0 never had an official build released for OSX, but this is something we'll be supporting permanently going forward. This was another often-requested feature, and makes it easy to use Chronograf as part of a development workflow on OSX.

We'll explore other distribution methods in the future, but for now we'll be using the [homebrew-binary](https://github.com/Homebrew/homebrew-binary) tap for [Homebrew](http://brew.sh/). You can keep an eye on [this PR](https://github.com/Homebrew/homebrew-binary/pull/270) for exact availability.

## Cloud-based registration

The first thing you'll notice when setting up Chronograf is that it requires registration with InfluxData Enterprise. We'll be talking about this more soon, but for now just know that it's a free registration that will allow us to offer better release management and functionality for Chronograf going forward.

## Give it a try!

We hope that this quick recap of the latest Chronograf features have made it a more powerful tool for working with InfluxDB. We look forward to hearing from everyone in the community on what you'd love to see next.

That's all we've got for now - head on over to the [download](https://influxdb.com/chronograf/index.html) page and grab Chronograf v0.2.0 and keep an eye out here for more posts about how to get the most out of Chronograf!

**Note: Chronograf v0.2.0 should work with most v0.9.x versions of InfluxDB, but we recommend using v0.9.4.2 or higher to take advantage of the latest measurement exploration updates.**
