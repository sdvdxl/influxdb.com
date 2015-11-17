---
title: Announcing Telegraf 0.2.1 with Support for Writing UDP to InfluxDB and Multiple Outputs of the Same Type
author: Cameron Sparr
date: 2015-11-17
publishdate: 2015-11-17
---

## Release Notes
- UDP InfluxDB output now supported
- Telegraf will now compile on FreeBSD
- Users can now specify outputs as lists, allowing multiple outputs of the
same type.
- Telegraf will no longer use docker-compose for "long" unit test, it has been
changed to run docker commands in the Makefile. See `make docker-run` and
`make docker-kill`. `make test` will still run all unit tests with docker.
- Long unit tests are now run in CircleCI, with docker & race detector
- Redis plugin tag has changed from `host` to `server`
- HAProxy plugin tag has changed from `host` to `server`

## Features
- [#325](https://github.com/influxdb/telegraf/pull/325): NSQ output. Thanks @[jrxFive](https://github.com/jrxFive)!
- [#318](https://github.com/influxdb/telegraf/pull/318): Prometheus output. Thanks @[oldmantaiter](https://github.com/oldmantaiter)!
- [#338](https://github.com/influxdb/telegraf/pull/338): Restart Telegraf on package upgrade. Thanks @[linsomniac](https://github.com/linsomniac)!
- [#337](https://github.com/influxdb/telegraf/pull/337): Jolokia plugin, thanks @[saiello](https://github.com/saiello)!
- [#350](https://github.com/influxdb/telegraf/pull/350): Amon output.
- [#365](https://github.com/influxdb/telegraf/pull/365): Twemproxy plugin by @[codeb2cc](https://github.com/codeb2cc)
- [#317](https://github.com/influxdb/telegraf/issues/317): ZFS plugin, thanks @[cornerot](https://github.com/cornerot)!
- [#364](https://github.com/influxdb/telegraf/pull/364): Support InfluxDB UDP output.
- [#370](https://github.com/influxdb/telegraf/pull/370): Support specifying multiple outputs, as lists.
- [#372](https://github.com/influxdb/telegraf/pull/372): Remove gosigar and update go-dockerclient for FreeBSD support. Thanks @[MerlinDMC](https://github.com/MerlinDMC)!

## Bugfixes
- [#331](https://github.com/influxdb/telegraf/pull/331): Dont overwrite host tag in redis plugin.
- [#336](https://github.com/influxdb/telegraf/pull/336): Mongodb plugin should take 2 measurements.
- [#351](https://github.com/influxdb/telegraf/issues/317): Fix continual "CREATE DATABASE" in writes
- [#360](https://github.com/influxdb/telegraf/pull/360): Apply prefix before ShouldPass check. Thanks @[sotfo](https://github.com/sotfo)!
