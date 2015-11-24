---
title: InfluxDB Week in Review - October 26, 2015
author: Todd Persen
date: 2015-10-26
publishdate: 2015-10-26
---

In this post we’ll recap the most interesting InfluxDB related content you may have missed in the last week or so.

### Blogs, Videos, Articles, Docs and How-Tos

* [Testing InfluxDB Storage Engines](https://influxdb.com/blog/2015/10/20/testing_tsm.html)
* [Getting Started with Continuous Queries in InfluxDB - Part 1](https://influxdb.com/blog/2015/10/21/continuous_queries_part_1.html)
* [Monitoring HP OneView with InfluxDB and Grafana](http://thebsdbox.co.uk/?p=653)
* [How to use InfluxDB over SSL](http://ibroketheinternet.co.uk/blog/2015/10/21/influxdb-over-ssl/)
* [Managing Databases and Retention Policies](https://influxdb.com/docs/v0.9/query_language/database_management.html)
* [Tremolo: A library for using InfluxDB’s wireline protocol over UDP](http://tpitale.com/activesupport-notifications-to-influxdb-with-tremolo.html)

### Testimonials

![Bleemeo](/img/blog/bleemeo_logo.png)

### [Bleemeo](https://bleemeo.com/)

Bleemeo is a Cloud Monitoring as a Service platform. You can quickly connect your infrastructure to the Bleemeo Monitoring Cloud and get a web dashboard of your infrastructure health: discover what is under or over sized and be notified when something goes wrong. What did Bleemeo find compelling about InfluxDB?

* It was easy to install and deploy for both development and production environments
* Cluster capabilities without much burden
* Aggregation capabilities plus a python client


![5GTN](/img/blog/5gtn_logo.png)

### [5GTN](http://5gtn.fi/)

5GTN is a facility for research, development and testing in a realistic 5G network environment located on the premises of VTT and the University of Oulu. Fully functioning, it will form a dynamic and heterogeneous platform for developing and testing new applications, services, algorithms, technologies and systems. The testing environment collects metrics from various parts of the infrastructure, including the telco core backend, routers, IoT gateways, network application endpoints (QoS at IP level), host metrics (e.g., Telegraf), application level customized metrics and test execution metrics. As one of the analytics tools/backends 5GTN uses, InfluxDB is used as a datastore on top of which they create dashboards and visualizations to explore metrics data. What did 5GTN find compelling about InfluxDB? 

* Flexibility in taking in different types of measurements and diverse metadata (tags)
* Easy integration with existing visualization tools, e.g., Grafana
* Telegraf is a handy tool in the same ecosystem for host-based monitoring
* Open-source/free, good support, active and open development
* Responsive forums


![Clustree](/img/blog/clustree_logo.png)

### [Clustree](https://www.clustree.com/)

Clustree is a SaaS company that leverages internal & external data for evidence-based HR decisions. Clustree is the first talent management and internal mobility tool, that offers matching suggestions between talents, jobs and careers, using collective intelligence and the strategic business objectives of the company. What did Clustree find compelling about InfluxDB? Clustree was looking for a fast, scalable, distributed and open source TSDB. The quickly evolving features and maturity of InfluxDB in combination with a vibrant ecosystem (especially Grafana and Telgraf) gave them the confidence to use InfluxDB in production.

### Events

* Oct 28: [Introduction to Time Series Data & InfluxDB](http://marketing.influxdb.com/acton/form/16929/0006:d-0002/0/index.htm) - Webinar
* Nov 3: [Oredev](http://oredev.org/) - Malmo, Sweden
* Nov 11: [LISA Conference](https://www.usenix.org/conference/lisa15/conference-program/presentation/norton) - Washington, DC
* Nov 16: [QConSF](https://qconsf.com/) - San Francisco, CA
* Nov 18: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225732800/)
* Dec 16: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733155/)
* Jan 20: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733589/)
* Feb 17: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733782/)

### PRs == Free T-Shirts

We need your help [testing and benchmarking](https://influxdb.com/docs/v0.9/introduction/tsm_installation.html) the new storage engine! Open two PRs in the month of October and we'll send you a t-shirt plus a fistful of stickers. You'll also be halfway to a free [Hacktoberfest](https://hacktoberfest.digitalocean.com/) t-shirt from DigitalOcean and GitHub. Click [here](https://influxdb.com/blog/2015/10/05/digitalocean_hacktoberfest.html) to learn more about how to claim your stuff.

### TL;DR Tech Tips

### [Support long text data types](https://groups.google.com/forum/#!topic/influxdb/nzMC5RGSxVA)

**Q:** Does InfluxDB support long text types?

**A:** InfluxDB can store strings up to 64KB.

### [A Scala client for InfluxDB](https://groups.google.com/forum/#!topic/influxdb/tbyskXFDoeM)

**Q:** Is there an asynchronous client library for Scala and InfluxDB?

**A:** Thanks to Paul Goldbaum you can find a Scala client for InfluxDB [here](https://github.com/paulgoldbaum/scala-influxdb-client).

### Get your InfluxDB hoodie while they last!

Does your company have a cool app or product that uses InfluxDB in production? We'd love to feature it on influxdb.com and give you a shout out on social media. As a "thank you" gift, we'll send you an InfluxDB hoodie and a pack of stickers. Just [fill out this simple form](https://influxdb.com/testimonials/) and we'll let you know when your entry is live and the hoodie is in the mail. Drop us a line at contact@influxdb.com if you have any questions. Thanks for the support!

<style type="text/css">
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    margin-top: 3.5em;
    margin-bottom: -1.5em;
  }
</style>