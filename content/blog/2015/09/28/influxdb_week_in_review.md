---
title: InfluxDB Week in Review - September 28, 2015
author: Todd Persen
date: 2015-09-28
publishdate: 2015-09-28
---

In this post we’ll recap the most interesting InfluxDB related content you may have missed in the last week or so.

### Blogs

* [Announcing Telegraf 0.1.9 with Clustering, OpenTSDB and AMQP support](https://influxdb.com/blog/2015/09/23/announcing_telegraf_0_1_9.html)
* [How to use the SHOW STATS command and the _internal database to monitor InfluxDB](https://influxdb.com/blog/2015/09/22/monitoring_internal_show_stats.html)

### Events

* Oct 2 at [Gotham Go](http://gothamgo.com/) in NYC
* Nov 14th-15th at [Oredev](http://oredev.org/) in Sweden
* Nov 16th at [QConSF](https://qconsf.com/) in San Francisco

### InfluxDB Projects and Apps

### [Didi Kuaidi](http://www.xiaojukeji.com/index.html)

With over 100 million users in more than 300 cities, Didi competes with Uber in China making it one of the largest mobile-based transport service companies in the world. Because Didi has to manage thousands of servers, one of the biggest challenges they face is maintaining service availability as demand for its services grows. Didi has developed its own monitoring system with four core components: data collection, data storage, an abnormal event detector, and a data renderer. InfluxDB is leveraged as the backend for this critical system.

### [KNXMonitor](http://www.knxmonitor.com/)

KNXMonitor is the first cloud based remote debugging, monitoring and control system for KNX installations, requiring nothing but an off-the-shelf KNX IP-router and an Internet connection. KNXMonitor uses InfluxDB to store thousands of individual metrics for residential and commercial buildings using the KNX Protocol. This typically runs into the hundred's of datapoints per minute per building. They’ve been storing data reliably for over a year now using InfluxDB.

### TL;DR Tech Tips

[influxdb-java client support for InfluxDB 0.9.x](https://groups.google.com/forum/#!topic/influxdb/1BRLbWB5orM) 

**Q:** When will the influxdb-java client support InfluxDB 0.9.x?

**A:** Thanks to Stefan Majer, the Java client library has been updated and now supports InfluxDB 0.9.0 and higher.

[Support for derivative of a sum](https://groups.google.com/forum/#!topic/influxdb/YbbWL2KCyVk)

**Q:** Does InfluxDB support derivative of a sum? Something like: `select derivative(sum(value)) from requests_served group by time(1m);`

**A:** Currently it doesn’t. In the meantime, you could create continuous queries that calculate the sum for you. Then you can take the derivative of that resulting series.

### Announcements

**Get your InfluxDB hoodie while they last!**

Does your company have a cool app or product that uses InfluxDB in production? We'd love to feature it on influxdb.com and give you a shout out on social media. As a "thank you" gift, we'll send you an InfluxDB hoodie and a pack of stickers. Just [fill out this simple form](https://influxdb.com/testimonials/) and we'll let you know when your entry is live and the hoodie is in the mail. Drop us a line at contact@influxdb.com if you have any questions. Thanks for the support!
