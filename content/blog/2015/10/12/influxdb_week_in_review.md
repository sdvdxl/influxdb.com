---
title: InfluxDB Week in Review - October 12, 2015
author: Todd Persen
date: 2015-10-12
publishdate: 2015-10-12
---

In this post we’ll recap the most interesting InfluxDB related content you may have missed in the last week or so.

### Blogs, Videos, Articles, Docs and How-Tos

* [Blog: Announcing a new storage engine for InfluxDB](https://influxdb.com/blog/2015/10/07/the_new_influxdb_storage_engine_a_time_structured_merge_tree.html)
* [Blog: Designing a Storage Engine: From LSM Tree to B+Tree and Back Again](https://influxdb.com/docs/v0.9/concepts/storage_engine.html)
* [Docs: Updated schema exploration guide to help navigate databases, series, measurements and tags](https://influxdb.com/docs/v0.9/query_language/schema_exploration.html)
* [Docs: Updated query language guide for selecting, grouping and limiting the results of queries](https://influxdb.com/docs/v0.9/query_language/data_exploration.html)
* [Video: Intro to the new storage engine plus what’s coming in 0.9.5](https://vimeo.com/140372527)

<iframe src="https://player.vimeo.com/video/140372527" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen style="margin-left:180px; margin-bottom:50px;"></iframe>

### PRs == Free T-Shirts

We need your help [testing and benchmarking](https://influxdb.com/docs/v0.9/introduction/tsm_installation.html) the new storage engine! Open two PRs in the month of October and we'll send you a t-shirt plus a fistful of stickers. You'll also be halfway to a free [Hacktoberfest](https://hacktoberfest.digitalocean.com/) t-shirt from DigitalOcean and GitHub. Click [here](https://influxdb.com/blog/2015/10/05/digitalocean_hacktoberfest.html) to learn more about how to claim your stuff.


### Testimonials

![Mozilla](/img/blog/mozilla_logo.png)

### [Mozilla](https://raptor.mozilla.org/)

Mozilla’s Raptor project uses InfluxDB together with Grafana to track the performance statistics of core applications and devices running Firefox OS. For Mozilla, the most compelling feature of InfluxDB is its time-based grouping of records and the ability to aggregate results using mathematical functions. According to software engineer Eli Perelman, “By regularly testing our device builds and keeping that data in InfluxDB, we are able to run automated jobs which query the database and inform us when performance regressions occur. We heavily utilize the ability to aggregate data using mathematical functions to determine if builds have decreasing performance. InfluxDB provides an excellent product and service, and our tooling would not be as good as it is without it."

![AXA Group](/img/blog/axa_logo.png)

### [AXA Group](http://www.axa.com.hk)

AXA uses Influxdb to store metrics gathered from users on websites, servers, applications to be computed and are displayed using Grafana and their own, proprietary decisional scripts that can trigger alerts based on the behaviour of users. This solution is used on Asian and some Europeans websites. What did AXA find compelling about InfluxDB? Easy to use HTTP API and the ability to store A LOT of metrics!

![All Discounts Here](/img/blog/all_discounts_here_logo.png)

### [All Discounts Here](https://www.alldiscountshere.com)

The All Discounts Here mobile application helps shoppers find the best offers in town for goods and services. It allows you to receive new loyalty cards to your smartphone and store plastic ones in a digital format. Their app allows you to find latest discounts and promos by means of location services at any time. What did All Discounts Here find compelling about InfluxDB? Storing metrics, analytics data about those metrics, clustering and the Telegraf collector.

### Events

We’ve added two webinars to the events calendar. [Sign up](http://marketing.influxdb.com/acton/form/16929/0005:d-0002/0/index.htm) for this Wednesday’s in-depth technical webinar with Paul Dix where he’ll give an update on the status of the new storage engine and what to expect in in the 0.9.5 release.

* Oct 14: [Intro to the New InfluxDB Storage Engine](http://marketing.influxdb.com/acton/form/16929/0005:d-0002/0/index.htm) - Webinar
* Oct 22: [Denver Gophers Meetup](http://www.meetup.com/Denver-Go-Language-User-Group/events/225072795/) - Denver, CO
* Oct 28: [Introduction to Time Series Data & InfluxDB](http://marketing.influxdb.com/acton/form/16929/0006:d-0002/0/index.htm) - Webinar
* Nov 3: [Oredev](http://oredev.org/) - Malmo, Sweden
* Nov 16: [QConSF](https://qconsf.com/) - San Francisco, CA
* Nov 18: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225732800/)
* Dec 16: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733155/)
* Jan 20: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733589/)
* Feb 17: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733782/)

### TL;DR Tech Tips

### [Getting server version via a query](https://groups.google.com/forum/#!topic/influxdb/UVcEVrcuPp8)

**Q:** How do I retrieve basic server info for InfluxDB?

**A:** execute `SHOW DIAGNOSTICS`

### [XML or CSV format in HTTP API](https://groups.google.com/forum/#!topic/influxdb/-dh9AnJJ1mo)

**Q:** Is it possible to get data from the HTTP API on the 8086 port in a format other than JSON?

**A:** Not at the moment. The only format emitted by that endpoint is JSON. The command-line tool simply parses JSON and presents it in tabular format.

### October 2015 InfluxDB Newsletter

Missed this month’s newsletter? [Sign up](http://influxdb.us5.list-manage2.com/subscribe?u=4d17b6adac2728b1ea6e4926b&id=1d1558aa0d) to get the all month’s product announcements, testimonials and blog articles in one consolidated email. Check out [this month’s newsletter](http://us5.campaign-archive2.com/?u=4d17b6adac2728b1ea6e4926b&id=fc62d493d4) to see what you missed.

### Announcements

**Get your InfluxDB hoodie while they last!**

Does your company have a cool app or product that uses InfluxDB in production? We'd love to feature it on influxdb.com and give you a shout out on social media. As a "thank you" gift, we'll send you an InfluxDB hoodie and a pack of stickers. Just [fill out this simple form](https://influxdb.com/testimonials/) and we'll let you know when your entry is live and the hoodie is in the mail. Drop us a line at contact@influxdb.com if you have any questions. Thanks for the support!
