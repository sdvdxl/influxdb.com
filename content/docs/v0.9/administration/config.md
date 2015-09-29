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

* Use both the `config` and `-config` flags to combine the new configuration file with your old configuration file. In the example below, InfluxDB uses the union of the new configuration file and the old configuration file (`influx_v0.9.x.conf`), where any configurations in the old file take precedence over those in the new file.  
<br>
    ```
    influxd config -config /etc/influxdb/influx_v0.9.x.conf
    ```  

For a more detailed discussion, see the [Generate a configuration file](../introduction/installation.html#generate-a-configuration-file) section on the Installation page. 

## The configuration file
---
The following sections follow the structure of the [sample configuration file on GitHub](https://github.com/influxdb/influxdb/blob/master/etc/config.sample.toml) and offer detailed explanations of the different options.  Note that this documentation refers to the configuration file for the last official release - the configuration file on GitHub will always be slightly ahead of what is documented here.

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
Once every 24 hours InfluxDB reports anonymous data to m.influxdb.com. Those data include a unique, randomly-generated cluster identifier (an 8-byte Raft ID), OS, architecture, InfluxDB version, and metadata (🎁 help on clarifying metadata - users could interpret it to mean nearly anything). InfluxDB doesn't request, track, or store the IP addresses of those servers that report. InfluxDB uses these data primarily to track the number of deployed clusters for each version. 

**reporting-disabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Change this option to `true` to disable reporting.

## [meta]
This section handles some of the parameters for the InfluxDB cluster. Specifically, it controls the parameters for the Raft consensus group which coordinates metadata about the cluster. For step-by-step instructions on setting up a cluster, see the [setup guide](../guides/clustering.html). 

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
This section controls where the actual data for InfluxDB live and how they are flushed from the WAL. You may want to change the `dir` setting, but the WAL settings are an advanced configuration. The defaults should work for most systems.

**dir = "/var/opt/influxdb/data"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The directory where InfluxDB stores the data.

The following three WAL settings are for the b1 storage engine used in 0.9.2. They won't apply to any new shards created after upgrading to versions 0.9.3+. 
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **max-wal-size = 104857600**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The maximum size the WAL can reach before a flush. Defaults to 100MB.
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**wal-flush-interval = "10m"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The maximum time data can sit in the WAL before a flush.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**wal-partition-flush-delay = "2s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The delay time between each WAL partition being flushed.

The following WAL settings are for the storage engine in versions 0.9.3+.
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**wal-dir = "/var/opt/influxdb/wal"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For best throughput, the WAL directory and the data directory should be on different physical devices. If you have performance concerns, you will want to make this setting different from the `dir` in the [[data]](../administration/config.html#data) section.
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**wal-enable-logging = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable logging.

The following settings are for version 0.9.3 only. The WAL in versions 0.9.4+ no longer has five partitions. 

**# wal-ready-series-size = 25600**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When a series in the WAL in-memory cache reaches this size in bytes it is marked as ready to flush to the index.
  
**# wal-compaction-threshold = 0.6**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Flush and compact a partition once this ratio of series are over the ready size.

**# wal-max-series-size = 2097152**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Force a flush and compaction if any series in a partition gets above this size in bytes.

**# wal-flush-cold-interval = "10m"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Force a flush of all series and full compaction if there have been no writes in this amount of time. This is useful for ensuring that shards that are cold for writes don't keep a bunch of data cached in memory and in the WAL.

**# wal-partition-size-threshold = 20971520**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Force a partition to flush its largest series if it reaches this approximate size in bytes. Remember there are five partitions so you'll need at least five times this amount of memory. The more memory you have, the bigger this can be.

## [cluster]
This section handles non-Raft cluster behavior, which generally includes how data are shared across shards.

**shard-writer-timeout = "5s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The time within which a shard must respond to a write.🎁 What happens if this limit is exceeded? The write goes to hinted handoff?
 
 **write-timeout = "5s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The time within which a write operation must complete on the cluster.🎁If this fails is the write rejected? Is this related to the consistency setting or does this timeout happen before or after that consistency setting would apply?

## [retention]
This section controls the enforcement of retention policies for evicting old data.

**enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Change this to `false` to prevent InfluxDB from enforcing retention policies. 

**check-interval = "30m"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The rate at which InfluxDB checks to enforce a retention policy. 

## [monitor]
This section controls InfluxDB's [system self-monitoring](https://github.com/influxdb/influxdb/blob/master/monitor/README.md).

By default, InfluxDB writes the data to the `_internal` database. If that database does not exist, InfluxDB creates it automatically. The default retention policy on the `_internal` database is seven days. If you want to use a retention policy other than the seven-day retention policy, you must [create](../administration/administration.html#retention-policy-management) it. 

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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to the path of the certificate file.🎁 What happends if this is a different PEM from the one in the [http] section? Can they be different?

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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁Does this control whether we log every write event or not?

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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁What are the options? TCP, UDP, anything else?

**# consistency-level = "one"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set the number of nodes that must confirm the write. If the requirement is not met the return value will be either `partial write` if some points in the batch fail or `write failure` if all points in the batch fail. For more information, see the Query String Parameters for Writes section in the [Line Protocol Syntax Reference ](../write_protocols/write_syntax.html).

**# name-separator = "."**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

The next three options control how batching works. You should have this enabled otherwise you could get dropped metrics or poor performance. Batching will buffer points in memory if you have many coming in.

**# batch-size = 1000**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush if this many points get buffered.

**# batch-pending = 5**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The number of batches that may be pending in memory.

**# batch-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush at least this often even if it hasn't reached the configured batch-size.

**# name-schema = "type.host.measurement.device"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This option configures tag keys for parsing the metric name from graphite protocol; separated by `name-separator`. The "measurement" tag is special and the corresponding field will become the name of the metric. e.g. "type.host.measurement.device" will parse "server.localhost.cpu.cpu0" as:
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁 No default?

**# database = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The name of the database that you want to write to. 🎁 Default to collectd?

**# typesdb = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

The next three options control how batching works. You should have this enabled otherwise you could get dropped metrics or poor performance. Batching will buffer points in memory if you have many coming in.

**# batch-size = 1000**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush if this many points get buffered.

**# batch-pending = 5**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The number of batches that may be pending in memory.

**# batch-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush at least this often even if it hasn't reached the configured batch-size.

## [opentsdb]
Controls the listener for OpenTSDB data. See the [README](https://github.com/influxdb/influxdb/blob/master/services/opentsdb/README.md) on GitHub for more information.

**enabled = false**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `true` to enable openTSDB writes.

**# bind-address = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁Default?

**# database = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The name of the database that you want to write to. If the database does not exist, it will be created automatically when the input is initialized.🎁Default?

**# retention-policy = ""**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁Default?

The next three options control how batching works. You should have this enabled otherwise you could get dropped metrics or poor performance. Only points metrics received over the telnet protocol undergo batching.

**# batch-size = 1000**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush if this many points get buffered.

**# batch-pending = 5**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The number of batches that may be pending in memory.

**# batch-timeout = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush at least this often even if it hasn't reached the configured batch-size.

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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The input will flush at least this often even if it hasn't reached the configured batch-size.

## [continuous_queries]
This section controls how continuous queries run within InfluxDB.

**log-enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable logging for continuous query events.

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
This section controls the hinted handoff feature, which allows nodes to temporarily store queued data when one node of a cluster is down for a short period of time. Note that the hinted handoff has no function in a single node cluster.

🎁Any notes on what may need to be changed for most systems?

**enabled = true**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set this option to `false` to disable hinted handoff. 

**dir = "/var/opt/influxdb/hh"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

**max-size = 1073741824**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The maximum size of the hinted handoff queue.🎁What happens if this is exceeded? Are older writes pushed off the stack by newer ones? Do new writes for that node fail? Return failures to the client?

**max-age = "168h"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁Do points age-out after max-age? Do entire files age out? Are they silently dropped? Is anything logged or returned to STDERR?

**retry-rate-limit = 0**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁

**retry-interval = "1s"**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🎁


