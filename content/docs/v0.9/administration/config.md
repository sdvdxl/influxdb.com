---
title: Database Configuration
---

## The basics
---
Generate a new configuration file by running `influxd config` and redirecting the output to a file:
```
influxd config  > /etc/influxdb/influx_v0.9.x.conf
```

Start the influxd process using that configuration file with `influxd -config`:  
```
influxd -config /etc/influxdb/influx_v0.9.x.conf
```

## Upgrading your configuration file
___
While configuration files from prior versions of InfluxDB 0.9 should work with future releases, old files may lack options for new features. To keep your configuration file up-to-date we recommend doing one of the following:

* Generate a new configuration file with each InfluxDB upgrade. Any changes that you made to the old file will need to be manually ported to the new file.

* Use both the `config` and `-config` flags to combine the new configuration file with your old configuration file. In the example below, InfluxDB uses the union of the new configuration file and the old configuration file (`influx_v0.9.x.conf`), where any configurations in the old file trump those in the new file.  
<br>
    ```
    influxd config -config /etc/influxdb/influx_v0.9.x.conf
    ```

## The configuration file
---
The following sections follow the structure of the [sample configuration file on GitHub](https://github.com/influxdb/influxdb/blob/master/etc/config.sample.toml) and offer detailed explanations of the different options.

Configuration sections:  

* [reporting](../administration/config.html#reporting)  
* [[meta]](../administration/config.html#meta)  
* [[data]](../administration/config.html#data)  
* [[cluster]](../administration/config.html#cluster)  
* [[retention]](../administration/config.html#retention)  
* [[monitor]](../administration/config.html#monitor)  
* [[admin]](../administration/config.html#admin)  
* [[http]](../administration/config.html#http)  
* [[graphite]](../administration/config.html#graphite)  
* [[collectd]](../administration/config.html#collectd)  
* [[opentsdb]](../administration/config.html#opentsdb)  
* [[udp]](../administration/config.html#udp)  
* [[continuous_queries]](../administration/config.html#continuous-queries)  
* [[hinted-handoff]](../administration/config.html#hinted-handoff)  

## reporting
Once every 24 hours InfluxDB reports anonymous data to m.influxdb.com. Those data include Raft ID (random 8 bytes), OS, architecture, InfluxDB version, and metadata. InfluxDB doesn't track IP addresses of servers reporting. This is only used to track the number of instances running and the versions, which is very helpful for us. 

**reporting-disabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Change this option to `true` to disable reporting.

## [meta]
This section handles some of the parameters for the InfluxDB cluster. Specifically, it controls the parameters for the Raft consensus group which stores metadata about the cluster. For step-by-step instructions on setting up a cluster, see the [setup guide](../guides/clustering.html). 

**dir = "/var/opt/influxdb/meta"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The directory where InfluxDB stores `id`, `peers.json`, `raft.db`, and the `snapshots` directory.

> * `id` stores the identification number of the Raft peer: `1` for the first node to join the cluster, `2` for the second node, and `3` for the third node to join the cluster.
* `peers.json` stores the hostnames and ports of the three Raft peers.
* `snapshots` contains the server's snapshots taken for the purpose of log compaction.
* `raft.db` 🎁

**hostname = "localhost"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The `hostname` of the Raft peer. 

**bind-address = ":8088"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The `port` over which the Raft peer communicates.

**retention-autocreate = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**election-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The time that the follower waits for communication from the leader before the follower begins a new election. In practice, InfluxDB staggers this parameter for each 
Raft peer. The default should work for most systems.

**heartbeat-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The rate at which the leader sends heartbeats to the other Raft peers to preserve its leader status. You may want to alter this parameter depending on your network.

**leader-lease-timeout = "500ms"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**commit-timeout = "50ms"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

## [data]
This section controls where the actual shard data for InfluxDB live and how they are flushed from the WAL. You may want to change the `dir` setting, but the WAL settings are an advanced configuration. The defaults should work for most systems.

**dir = "/var/opt/influxdb/data"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The directory where InfluxDB stores the shard data.

The following three WAL settings are for the b1 storage engine used in 0.9.2. They won't apply to any new shards created after upgrading to versions 0.9.3+. 
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **max-wal-size = 104857600**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The maximum size the WAL can reach before a flush. Defaults to 100MB.
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**wal-flush-interval = "10m"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The maximum time data can sit in WAL before a flush.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**wal-partition-flush-delay = "2s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The delay time between each WAL partition being flushed.

The following WAL settings are for the storage engine in versions 0.9.3+.
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**wal-dir = "/var/opt/influxdb/wal"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**wal-enable-logging = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable logging.

🎁Any explanation for why the next lines are commented out?

**# wal-ready-series-size = 25600**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When a series in the WAL in-memory cache reaches this size in bytes it is marked as ready to flush to the index.
  
**# wal-compaction-threshold = 0.6**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Flush and compact a partition once this ratio of series are over the ready size.

**# wal-max-series-size = 2097152**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Force a flush and compaction if any series in a partition gets above this size in bytes.

**# wal-flush-cold-interval = "10m"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Force a flush of all series and full compaction if there have been no writes in this amount of time. This is useful for ensuring that shards that are cold for writes don't keep a bunch of data cached in memory and in the WAL.

**# wal-partition-size-threshold = 20971520**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Force a partition to flush its largest series if it reaches this approximate size in bytes. Remember there are 5 partitions so you'll need at least 5x this amount of memory. The more memory you have, the bigger this can be.

## [cluster]
This section handles non-Raft cluster behavior, which generally includes how data are shared across shards.

**shard-writer-timeout = "5s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The time within which a shard must respond to a write.
 
 **write-timeout = "5s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The time within which a write operation must complete on the cluster.

## [retention]
This section controls the enforcement of retention policies for evicting old data.

**enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Change this to `false` to prevent InfluxDB from enforcing retention policies. 

**check-interval = "30m"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The rate at which InfluxDB checks to enforce a retention policy. 

## [monitor]
This section controls InfluxDB's [system self-monitoring](https://github.com/influxdb/influxdb/blob/master/monitor/README.md).

The retention policy for these data is the default retention policy within the `_internal` database. If the `_internal` database does not exist, InfluxDB creates that database automatically with a default retention policy of infinite retention. If you want to use a retention policy other than infinite retention, you must [create](../administration/administration.html#retention-policy-management) it. 

**store-enabled = true**   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Whether to record statistics internally.

**store-database = "_internal"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The destination database for recorded statistics.

**store-interval = "10s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The interval at which to record statistics.

## [admin]
Controls the availability of the built-in, web-based admin interface.

>**Note:** If you want to enable HTTPS for the admin interface you must also enable HTTPS on the [[http]](../administration/config.html#http) service.

**enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable the admin interface.

**bind-address = ":8083"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The admin interface uses port `8083` by default.

**https-enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `true` to enable HTTPS for the admin interface.

**https-certificate = "/etc/ssl/influxdb.pem"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to the path of the certificate file.

## [http]
This section controls how InfluxDB configures the HTTP endpoints. These are the primary mechanism for getting data into and out of InfluxDB. Edit options in this section to enable HTTPS and authentication.

**enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable HTTP. Note that the InfluxDB CLI connects to the database using the HTTP API.

**bind-address = ":8086"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The HTTP API uses port `8086`  by default.

**auth-enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `true` to enable authentication.

**log-enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable logging.

**write-tracing = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**pprof-enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**https-enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `true` to enable HTTPS.

**https-certificate = "/etc/ssl/influxdb.pem"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to the path of the certificate file.

## [[graphite]]
This section controls one or many listeners for Graphite data. See the [README](https://github.com/influxdb/influxdb/blob/master/services/graphite/README.md) on GitHub for more information.

**enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this to `true` to enable Graphite input.

**# bind-address = ":2003"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

**# protocol = "tcp"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

**# consistency-level = "one"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

**# name-separator = "."**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

The next three options control how batching works. You should have this enabled otherwise you could get dropped metrics or poor performance. Batching will buffer points in memory if you have many coming in.

**# batch-size = 1000**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush if this many points get buffered.

**# batch-pending = 5**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The number of batches that may be pending in memory.

**# batch-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush at least this often even if we haven't reached the configured batch size.

**# name-schema = "type.host.measurement.device"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This option configures tag names for parsing the metric name from graphite protocol; separated by `name-separator`. The "measurement" tag is special and the corresponding field will become the name of the metric. e.g. "type.host.measurement.device" will parse "server.localhost.cpu.cpu0" as:
<br>
<br>
```
  ## {
  ##     measurement: "cpu",
  ##     tags: {
  ##         "type": "server",
  ##         "host": "localhost,
  ##         "device": "cpu0"
  ##     }
  ## }
```

**ignore-unnamed = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If set to `true`, when the input metric name has more fields than `name-schema` specified, the extra fields will be ignored. Otherwise an error will be logged and the metric rejected.

## [collectd]
This section controls the listener for Collectd data.

**enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `true` to enable Collectd writes.

**# bind-address = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

**# database = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The name of the database that you want to write to.

**# typesdb = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

The next three options control how batching works. You should have this enabled otherwise you could get dropped metrics or poor performance. Batching will buffer points in memory if you have many coming in.

**# batch-size = 1000**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush if this many points get buffered.

**# batch-pending = 5**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The number of batches that may be pending in memory.

**# batch-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush at least this often even if we haven't reached the configured batch-size.

## [opentsdb]
Controls the listener for OpenTSDB data. See the [README](https://github.com/influxdb/influxdb/blob/master/services/opentsdb/README.md) on GitHub for more information.

**enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `true` to enable openTSDB writes.

**# bind-address = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

**# database = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The name of the database that you want to write to. If the database does not exist, it will be created automatically when the input is initialized.

**# retention-policy = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

The next three options control how batching works. You should have this enabled otherwise you could get dropped metrics or poor performance. Only points metrics received over the telnet protocol undergo batching.

**# batch-size = 1000**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush if this many points get buffered.

**# batch-pending = 5**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The number of batches that may be pending in memory.

**# batch-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush at least this often even if we haven't reached the configured batch-size.

## [[udp]]
This section controls the listeners for InfluxDB line protocol data via UDP. See the [UDP page](../write_protocols/udp.html) for more information.

**enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `true` to enable writes over UDP.

**# bind-address = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

**# database = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The name of the database that you want to write to.

The next three options control how batching works. You should have this enabled otherwise you could get dropped metrics or poor performance. Batching will buffer points in memory if you have many coming in.

**# batch-size = 1000**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Will flush if this many points get buffered.

**# batch-pending = 5**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The number of batches that may be pending in memory.

**# batch-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Will flush at least this often even if we haven't reached the configured batch-size.

## [continuous_queries]
This section controls how continuous queries run within InfluxDB.

**log-enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable logging.

**enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable continuous queries.

**recompute-previous-n = 2**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**recompute-no-older-than = "10m"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The maximum interval over which the continuous query will recompute results.

**compute-runs-per-interval = 10**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**compute-no-more-than = "2m"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

## [hinted-handoff]
This section controls the hinted handoff feature, which allows nodes to temporarily store queued data when one node of a cluster is down for a short period of time.

🎁Any notes on what may need to be changed for most systems?

**enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable hinted handoff. 

**dir = "/var/opt/influxdb/hh"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

**max-size = 1073741824**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The maximum size of the hinted handoff queue.

**max-age = "168h"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**retry-rate-limit = 0**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**retry-interval = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁


