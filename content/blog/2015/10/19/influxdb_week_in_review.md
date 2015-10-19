---
title: InfluxDB Week in Review - October 19, 2015
author: Todd Persen
date: 2015-10-19
publishdate: 2015-10-19
---

In this post we’ll recap the most interesting InfluxDB related content you may have missed in the last week or so.

### Blogs, Videos, Articles, Docs and How-Tos

* [Blog: Announcing Windows Installation Packages for InfluxDB](https://influxdb.com/blog/2015/10/09/windows_installer_times_series_database.html)
* [Blog: Collecting and Visualizing Metrics with statsd, InfluxDB and Grafana on Fedora 22](http://www.schakko.de/2015/10/13/collecting-and-visualizing-metrics-with-statsd-influxdb-and-grafana-on-fedora-22/)
* [Blog: Columned Graphite Data in InfluxDB](http://roobert.github.io/2015/10/10/Columned-Graphite-Data-in-InfluxDB/)
* [Slides: Introduction to the New InfluxDB Storage Engine](https://speakerdeck.com/pauldix/influxdbs-new-storage-engine-the-time-structured-merge-tree)
* [Docs: Getting Started with Authentication and Authorization in InfluxDB](https://influxdb.com/docs/v0.9/administration/authentication_and_authorization.html)

<iframe src="https://player.vimeo.com/video/142540768" width="500" height="375" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

### PRs == Free T-Shirts

We need your help [testing and benchmarking](https://influxdb.com/docs/v0.9/introduction/tsm_installation.html) the new storage engine! Open two PRs in the month of October and we'll send you a t-shirt plus a fistful of stickers. You'll also be halfway to a free [Hacktoberfest](https://hacktoberfest.digitalocean.com/) t-shirt from DigitalOcean and GitHub. Click [here](https://influxdb.com/blog/2015/10/05/digitalocean_hacktoberfest.html) to learn more about how to claim your stuff.

### Testimonials

![Geographite](/img/blog/geographite_logo.png)

### [GeoGraphite](http://www.geographite.com/)

GeoGraphite is a tool for displaying time-series data with a spatial component. Possible applications include creating dashboard maps for sensor networks, vehicle fleets, or operational activity. Data can be displayed as individual points or aggregated into visualizations like a heat map. What did GeoGraphite find compelling about InfluxDB? The ability to include multiple values per data point was key as they wanted to store latitude and longitude alongside the metric. Compatibility with existing graphing tools like Grafana was also important.

![Smarsh](/img/blog/smarsh_logo.png)

### [Smarsh](http://www.smarsh.com/)

Smarsh uses InfluxDB as a swap in replacement for graphite for storing system, networking, application metrics. Smarsh also leverages Telegraf as a local state check for system and services for its alerting infrastructure. What did Smarsh find compelling about InfluxDB? The ease of deploying, a simple HTTP API, and the ability to perform statistical analysis on measurements. Plus, Telegraf being a drop in replacement for diamond that can be easily wrapped around other tooling mechanisms.

![Row44](/img/blog/row44_logo.png)

### [Row44](http://www.geemedia.com/)

Row 44, Inc. provides satellite-based in-flight broadband for commercial aircraft – a wireless hotspot in the sky. The solution provides passengers with connectivity and in-flight entertainment, while providing operations data and other services to cockpit and crew. Row44's custom monitoring solution called, "[Watcher](https://github.com/catdude/watcher)" serves as a backup to their "big-bucks" monitoring system. Watcher leverages Telegraf, InfluxDB and potentially Chronograf in the future. What did Row44 find compelling about InfluxDB? According to Dan Mahoney, Software Engineer at Row44, “1. It's not MySQL. 2. Created to be time-series centric from the beginning. 3. It’s easy to use.”

### Events

We’ve added two webinars to the events calendar. [Sign up](http://marketing.influxdb.com/acton/form/16929/0005:d-0002/0/index.htm) for this Wednesday’s in-depth technical webinar with Paul Dix where he’ll give an update on the status of the new storage engine and what to expect in in the 0.9.5 release.

* Oct 22: [Denver Gophers Meetup](http://www.meetup.com/Denver-Go-Language-User-Group/events/225072795/) - Denver, CO
* Oct 28: [Introduction to Time Series Data & InfluxDB](http://marketing.influxdb.com/acton/form/16929/0006:d-0002/0/index.htm) - Webinar
* Nov 3: [Oredev](http://oredev.org/) - Malmo, Sweden
* Nov 16: [QConSF](https://qconsf.com/) - San Francisco, CA
* Nov 18: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225732800/)
* Dec 16: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733155/)
* Jan 20: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733589/)
* Feb 17: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733782/)

### TL;DR Tech Tips

### [How to query from all retention policies?](https://groups.google.com/forum/#!topic/influxdb/Hcj9wBnXVLs)

**Q:** How can I query a timeseries from all defined retention policies?

**A:** There is currently no way to return results from more than one retention policy in a single query. 

 
### [What is the point of the WAL?](https://groups.google.com/forum/#!topic/influxdb/Gp8YoLfpLxg)

**Q:** Isn’t it better for the WAL to be disabled by default?

**A:** The WAL allows the database to absorb temporary spikes in write volume that would otherwise lead to timeouts and failed writes. We believe for this reason it’s preferable to have it enabled by default. Batching of writes is recommended for best performance, but it is not required.

### Announcements

**Get your InfluxDB hoodie while they last!**

Does your company have a cool app or product that uses InfluxDB in production? We'd love to feature it on influxdb.com and give you a shout out on social media. As a "thank you" gift, we'll send you an InfluxDB hoodie and a pack of stickers. Just [fill out this simple form](https://influxdb.com/testimonials/) and we'll let you know when your entry is live and the hoodie is in the mail. Drop us a line at contact@influxdb.com if you have any questions. Thanks for the support!
