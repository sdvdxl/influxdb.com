---
title: InfluxDB Week in Review - November 2, 2015
author: Todd Persen
date: 2015-11-02
publishdate: 2015-11-02
---

In this post we’ll recap the most interesting InfluxDB related content you may have missed in the last week or so.

### Blogs, Videos, Articles, Docs and How-Tos

* [Announcing Telegraf 0.2 with StatsD, MQTT and Improved Scalability](https://influxdb.com/blog/2015/10/28/announcing_telegraf_0_2_0.html)
* [Create an Alternative to New Relic with Ruby, Sinatra, Grafana & InfluxDB](https://mic-kul.com/2015/10/24/garage-made-self-hosted-newrelic-collector-using-ruby-sinatra-grafana-and-influxdb/)
* [Install and Configure Telegraf with Ansible](https://github.com/dj-wasabi/ansible-telegraf)
* [What’s Difference Between InfluxDB and Prometheus?](http://stackoverflow.com/questions/33350314/usecases-influxdb-vs-prometheus/)
* [Understanding Key Concepts in InfluxDB](https://influxdb.com/docs/v0.9/concepts/key_concepts.html)
* [Java API to Access the InfluxDB REST API](http://mvnrepository.com/artifact/org.influxdb/influxdb-java/2.0)
* [Visualizing Network Stats using InfluxDB, Grafana & influxsnmp](http://lkhill.com/using-influxdb-grafana-to-display-network-statistics/)

### Testimonials

![eBay](/img/blog/ebay_logo.png)

### [eBay | mobile.de](http://www.mobile.de/)

mobile.de is Germany's biggest online vehicle marketplace. Think of it as the German version of eBay Motors. eBay acquired mobile.de in 2004. eBay uses InfluxDB for trend checks. They capture metrics from several systems including mongodb, varnish, rabbitmq, squid, (and many more) and analyze the data week over week, month over month and so on, trying to spot anomalies. Everything is hooked up with sensu and they use grafana to visualize the data. What did they find to be InfluxDB’s most compelling feature? Clustering.

![Muzzley](/img/blog/muzzley_logo.png)

### [Muzzley](https://www.muzzley.com/)

Automating your home can be tough, but Muzzley makes home automation a breeze. Muzzley gets all your smart devices to work together in a way that adapts to your preferences. No wires, no hubs, no fuss. Just your smartphone and the devices you love. InfluxDB allowed them to easily set up a platform to not only monitor their systems and services, but to also register key information transmitted through their systems in real time. They needed a quick way to deal with this information in an accurate way and InfluxDB proved to be exactly what they were looking for.

![Mothership1](/img/blog/mothership1_logo.png)

### [Mothership1](https://www.mothership1.com/)

Mothership1 is a joint venture between CentriLogic and Incubaid focused on offering a more affordable, comprehensive cloud deployment choice for software developers, VARs and small and midsize businesses, compared to Amazon Web Services, Digital Ocean, Microsoft and Google. In a nutshell, Mothership1 is a public/private cloud (IaaS and PaaS) provider which provides its clients with Cloud spaces, very advanced networking features, Windows VMs among other cool features. Mothership1 is using InfluxDB for monitoring their apps and services across multiple data centers, infrastructure and users' activity (for pricing). What did Mothership1 find compelling about InfluxDB?

* SQL-like query language
* Merge series queries
* Wildcard queries
* Continuous queries (also used in creating other series for aggregations)
* Self-contained, no-dependencies binary

### Events

* Nov 3: [Oredev](http://oredev.org/) - Malmo, Sweden
* Nov 11: [LISA Conference](https://www.usenix.org/conference/lisa15/conference-program/presentation/norton) - Washington, DC
* Nov 16: [QConSF](https://qconsf.com/) - San Francisco, CA
* Nov 18: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225732800/)
* Dec 16: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733155/)
* Jan 20: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733589/)
* Feb 17: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733782/)

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
