---
title: InfluxDB Week in Review - November 16, 2015
author: Todd Persen
date: 2015-11-16
publishdate: 2015-11-16
---

In this post we’ll recap the most interesting InfluxDB related content you may have missed in the last week or so.

### Blogs, Videos, Articles, Docs and How-Tos

* [Announcement: InfluxDB 0.9.5 RC2 is Ready for Download](https://influxdb.com/blog/2015/11/13/InfluxDB-0_9_5-rc2-released.html)
* [Using Functions to Aggregate, Select and Transform Data](https://influxdb.com/docs/v0.9/query_language/functions.html)
* [Getting Started with Continuous Queries - Part 2](https://influxdb.com/blog/2015/11/10/continuous_queries_part_2.html)
* [Managing Massive Data Sets with InfluxDB ](https://vimeo.com/144664878)
* [Getting Started as an Open Source Developer and Contributor](https://influxdb.com/blog/2015/11/11/do_you_want_to_be_an_open_source_developer.html)

### Testimonials

![NIST-ARTIQ](/img/blog/nist_artiq_logo.png)

### [National Institute of Standards & Technology](http://www.nist.gov/) - [ARTIQ Project](https://github.com/m-labs/artiq)

NIST is a federal technology agency that works with industry to develop and apply technology, measurements, and standards. The ARTIQ (Advanced Real-Time Infrastructure for Quantum physics) project is a next-generation control system for quantum information experiments. It is developed in partnership with the Ion Storage Group at NIST, and its applicability reaches beyond ion trapping. The system features a high-level programming language that helps describing complex experiments, which is compiled and executed on dedicated hardware with nanosecond timing resolution and sub-microsecond latency. We use InfluxDB as a backend to log and analyze everything about our quantum physics experiments: from vacuum pressures, environmental parameters, and laser powers, to qubit transition frequencies, single ion fluorescence, and quantum gate fidelities. What did they find compelling about InfluxDB?

* Speed
* Ease of use
* Ease of integration

![SwitchBoard](/img/blog/switchboard_logo.png)

### [Switchboard Software](http://www.switchboard-software.com/#)

Switchboard is built from the ground up to manage, move and monitor data so you don’t have to. Their product suite includes an operations dashboard and visual data pipelines that are designed to be scalable up to terabytes per day. The typical use cases for Switchboard are digital marketing, user activity analysis, and ad hoc data analysis on an industrial-scale. InfluxDB is used for the monitoring of their production ETL pipelines.

![Recommend](/img/blog/recommend_logo.png)

### [Recommend](http://re.co/#/)

Recomend is a social network about recommendations. Recommend enables you to find the best advice from people you trust, save your own relevant experiences and share them with your network. What did the team at Recommended find compelling about InfluxDB?

* Ease of use and deployment
* The Golang ecosystem
* Completeness of solution (influxdb, telegraf and chronograf) plus grafana integration

### Events

* Nov 16: [QConSF](https://qconsf.com/) - San Francisco, CA
* Nov 18: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225732800/)
* Nov 30: [Women Who Go Meetup](http://www.meetup.com/Women-Who-Go/) - San Francisco, CA
* Dec 16: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733155/)
* Jan 20: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733589/)
* Feb 17: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733782/)

### TL;DR Tech Tips

__Q: Can Telegraf deal with tags modified dynamically without having to restart the daemon?__

__A:__ Currently, there’s no support for changing tags on the fly, so you will need to restart the daemon.

[Read the full thread.](https://groups.google.com/forum/#!topic/influxdb/iej5vVrdvfQ)

__Q: What’s the best way to backup InfluxDB periodically?__

__A:__ The best way to back up InfluxDB 0.9 right now is to take filesystem level backups of /data and /meta. Ideally when the system is not under heavy write load. Incremental backups are coming with the tsm1 engine, but are not yet available with the existing b1/bz1 engines.

[Read the full thread.](https://groups.google.com/forum/#!topic/influxdb/smKVJMmWyuw)

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
