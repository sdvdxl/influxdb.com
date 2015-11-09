---
title: InfluxDB Week in Review - November 9, 2015
author: Todd Persen
date: 2015-11-09
publishdate: 2015-11-09
---

In this post we’ll recap the most interesting InfluxDB related content you may have missed in the last week or so.

### Blogs, Videos, Articles, Docs and How-Tos

* [Contribute to OSS: Find Simple and Challenging PRs in InfluxDB](https://influxdb.com/blog/2015/11/05/start_contributing.html)
* [InfluxDB Glossary of Terms](https://influxdb.com/docs/v0.9/concepts/glossary.html)
* [How to send Statsd metrics to Telegraf - InfluxDB’s Native Collection Agent](https://influxdb.com/blog/2015/11/03/getting_started_with_influx_statsd.html)
* [Monitor Icecast and Wowza Listeners with Docker, Grafana and InfluxDB](https://medium.com/@lePeco/monitor-icecast-and-wowza-listeners-with-dockerized-influxdb-grafana-and-go-6212bb208988)
* [How Citrix Gets Visibility Into It’s Agile Development Process with InfluxDB & Grafana](https://www.citrix.com/blogs/2015/11/05/information-radiation-with-influxdb-and-grafana/)
* [NoSQL vs SQL: Choosing a Data Management Solution](http://www.javacodegeeks.com/2015/10/nosql-vs-sql.html)
* [Monitoring App Internals with InfluxDB and Symfony2](http://www.slideshare.net/corleycloud/measure-your-app-internals-witth-influxdb-and-symfony2)

### Testimonials

![LeTV](/img/blog/letv_logo.png)

### [LeTV](http://www.letv.com/)

Leshi Internet Information & Technology, also known as LeTV, is a Chinese entertainment company and one of the largest online video providers in China. Think of it as the Netflix of China among the other services it provides. The company is headquartered in Beijing, has 5,000+ employees and overseas operations in both the US and India. LeTV is developing its own custom monitoring platform with InfluxDB. This system is designed for the real-time monitoring of millions of metrics collected from more than 10,000 servers, virtual machines and network devices. InfluxDB is used to store all of the monitoring system's data. What did they find to be InfluxDB’s most compelling feature? Clustering.

![GfK](/img/blog/gfk_logo.png)

### [GfK](http://www.gfk.com/us/Pages/default.aspx)

GfK is the fourth largest market research company in the world with more than 13,000 market research experts in over 100 countries. GfK turns big data into smart data, enabling its clients to improve their competitive edge and enrich consumers’ experiences and choices. InfluxDB will at the heart of a new research platform that will process metrics in real time. More specifically, InfluxDB and telegraf will be used to feed real time metrics from Kafka for visualization in Grafana.

![ProcessOut](/img/blog/processout_logo.png)

### [ProcessOut](https://www.processout.com/)

ProcessOut provides an easy to use payment aggregation gateway to companies and individuals. Integrating payments can be long, painful, and expensive, especially when one needs to expand internationally. With ProcessOut, one integration takes less than 5 minutes for the most advanced use cases and gives the ability for a company to reach broader audiences by providing local payment options.Custom DevOps solutions. ProcessOut needed a powerful database to build a user statistics repository while keeping it lightweight. Choosing InfluxDB made it incredibly easy for them.

### Events

* Nov 11: [LISA Conference](https://www.usenix.org/conference/lisa15/conference-program/presentation/norton) - Washington, DC
* Nov 16: [QConSF](https://qconsf.com/) - San Francisco, CA
* Nov 18: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225732800/)
* Dec 16: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733155/)
* Jan 20: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733589/)
* Feb 17: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733782/)

### TL;DR Tech Tips

__Q: Which has less overhead, a few big databases or many small databases?__

__A:__ In depends on your use case, but remember that each new database means a unique set of shards on disk. Creating thousands of databases will multiply the number of files on disk and may lead to performance issues with the filesystem.

[Read the full thread.](https://groups.google.com/forum/?pli=1#!topic/influxdb/l8pHwdoS1eQ)

__Q: Is it possible to create a single node and at a later point integrate it with another node, transforming the combined nodes into a cluster?__

__A:__ Yes, although the data written to the single node will not be replicated to the new node and the new node will need to be a fresh InfluxDB install without data. However, we wouldn’t recommend this as it is simply increasing complexity and does not increase redundancy or availability for the data written before the cluster is created.

[Read the full thread.](https://groups.google.com/forum/?pli=1#!topic/influxdb/yqbsakbw7qU)

### Get your InfluxDB hoodie while they last!

Does your company have a cool app or product that uses InfluxDB in production? We'd love to feature it on influxdb.com and give you a shout out on social media. As a "thank you" gift, we'll send you an InfluxDB hoodie and a pack of stickers. Just [fill out this simple form](https://influxdb.com/testimonials/) and we'll let you know when your entry is live and the hoodie is in the mail. Drop us a line at contact@influxdb.com if you have any questions. Thanks for the support!

<style type="text/css">
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    margin-top: 3.5em;
    margin-bottom: -1.5em;
    max-width: 75%;
  }
</style>
