---
title: InfluxDB Week in Review - October 5, 2015
author: Todd Persen
date: 2015-10-05
publishdate: 2015-10-05
---

In this post we’ll recap the most interesting InfluxDB related content you may have missed in the last week or so.

### Blogs, Articles and How-Tos

* [Announcing Chronograf 0.2.0 with Embedded Graphs, Custom Time Ranges and More!](https://influxdb.com/blog/2015/10/01/announcing_chronograf_0_2_0.html)
* [How to send sensor data to InfluxDB from Arduino Uno](https://influxdb.com/blog/2015/09/29/how_to_send_sensor_data_to_influxdb_from_an_arduino_uno.html)
* [Google Go: Why Google’s Programming Language Can Rival Java in the Enterprise (How Mondo uses Go and InfluxDB)](http://www.techworld.com/apps/why-googles-go-programming-language-could-rival-java-in-enterprise-3626140/)
* [Recap of the M.E.L.I.G. Meetup (feat. InfluxDB)](http://qnib.org/2015/10/01/melig-1/)
* [Scaling Graphite Deployments with Go](https://influxdb.com/blog/2015/09/30/scale_graphite_golang_graphite-ng.html)

### Events

If you are in the Bay Area and using InfluxDB, come check out the new [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/)!

**2015**

* Oct 6: [CVDev Group](http://www.cvdevgroup.org/) in Eau Claire, WI
* Oct 22: [Denver Gophers Meetup](http://www.meetup.com/Denver-Go-Language-User-Group/events/225072795/) in Denver, CO
* Nov 14: [Oredev](http://oredev.org/) in Malmo, Sweden
* Nov 16: [QConSF](https://qconsf.com/) in San Francisco, CA
* Nov 18: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225732800/)
* Dec 16: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733155/)

**2016**

* Jan 20: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733589/)
* Feb 17: [San Francisco InfluxDB Meetup](http://www.meetup.com/San-Francisco-InfluxDB-Meetup/events/225733782/)

### Companies Using InfluxDB

[Mirantis](https://www.mirantis.com/products/openstack-drivers-and-plugins/fuel-plugins/)

![Mirantis](/img/blog/mirantis.png)

Mirantis is the pure play OpenStack company, providing all the software, services, training and support you need to run a production deployment of OpenStack at scale. InfluxDB is used to store and query the time-series they collect at the OpenStack infrastructure level. The use of InfluxDB is part of a larger logging, monitoring and alerting toolchain they provide as Fuel plugins for Mirantis OpenStack monitoring. Check out the [Fuel Plugins Catalog](https://www.mirantis.com/products/openstack-drivers-and-plugins/fuel-plugins/) to learn more or watch the [video](https://www.youtube.com/watch?v=gXc7HxcCu9A&list=PLRkaKWXET-H5jXIsNP62j6wTUA7J9CVBg&index=4).

[Datacentred](http://www.datacentred.co.uk/)

![Datacentred](/img/blog/datacentred.png)

Datacentred is a Manchester, UK-based startup offering public and private cloud services based on OpenStack and Ceph, as well as datacenter colocation. Datacentred is the biggest UK-owned and operated OpenStack public cloud provider. They are heavily focused on open-source, members of the Linux Foundation, plus sponsors the OpenStack project. Datacentred is an avid user of Graphite in conjunction with Grafana, however the pain of scaling the former hit them early which led them to evaluating alternatives. InfluxDB won out based on its features, performance, ease of deployment and technical roadmap. They are currently in the process of migrating their existing performance monitoring infrastructure away from collectd + Graphite over to telegraf and InfluxDB.

[CATS Software](https://www.catsone.com/)

![CATS Software](/img/blog/cats.png)

CATS is a an applicant tracking system used by thousands of companies all over the world. It manages the entire hiring process, from posting jobs and screening candidates to reporting on hiring campaigns. They host career portals to manage incoming applications and provide powerful searching, reporting, and workflow tools for internal hiring, recruiters and staffing agencies. What did they find compelling about InfluxDB? Ease of deployment, awesome query language and simple API. Telegraf made it incredibly easy for them to monitor instance metrics, and the nice web interface was a huge bonus. They replaced Graphite with InfluxDB with almost no hassle, and have been super happy with the results so far.


### TL;DR Tech Tips

### [Accessing InfluxDB logs on CentOS](https://groups.google.com/forum/#!topic/influxdb/RFL8Rg61jLk)

**Q**: Where can I find the InfluxDB logs on CentOS 7?

**A**: When when using a distribution that relies on systemd, the usual sysv init scripts are no longer used and output is captured by journald. Logs related to InfluxDB can be accessed by using the command `journalctl -u influxdb`.

### [SNMP collector for InfluxDB 0.9.x](https://groups.google.com/forum/#!topic/influxdb/bRN1CrnN5V4)

**Q**: Is there an SNMP collector for InfluxDB 0.9.x?

**A**: Thanks to Paul Stuart, there is now an SNMP collector written in Go that supports InfluxDB 0.9.0 and higher.

### Announcements

**Get your InfluxDB hoodie while they last!**

Does your company have a cool app or product that uses InfluxDB in production? We'd love to feature it on influxdb.com and give you a shout out on social media. As a "thank you" gift, we'll send you an InfluxDB hoodie and a pack of stickers. Just [fill out this simple form](https://influxdb.com/testimonials/) and we'll let you know when your entry is live and the hoodie is in the mail. Drop us a line at contact@influxdb.com if you have any questions. Thanks for the support!
