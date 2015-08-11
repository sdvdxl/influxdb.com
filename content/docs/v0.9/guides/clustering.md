---
title: Clustering
aliases:
  - /docs/v0.9/guides/clustering.html
---

> **Note:** Clustering is still in a beta state right now. There are still a good number of rough edges. If you notice any issues please [report them](https://github.com/influxdb/influxdb/issues/new).


Starting with version 0.9.3, Influxdb supports adding new data nodes to a cluster.

The first three nodes to join a cluster are raft `peers`. All subsequent nodes are data nodes and do not participate in consensus.

## Configuration

While you build a cluster starting with a single node, it is currently recommended that you should first start with a cluster of **3** and then grow from there.

### Start the Initial Cluster

1. Install InfluxDB on the first 3 machines.
2. For each nodes `/etc/opt/influxdb/influxdb.conf` file, replace `hostname = "localhost"` with your hosts actual name.
3. For each nodes `/etc/opt/influxdb/influxdb.conf` file, update the `bind-address` to another port if `8088` is unacceptable.
4. For each nodes `/etc/opt/influxdb/influxdb.conf` file, add `peers = ["<hostname 1>:<bind-address 1>","<hostname 2>:<bind-address 2>","<hostname 3>:<bind-address 1>"]`
5. For each nodes `/etc/opt/influxdb/influxdb.conf` file, set `replication = 3` in the `[retention]` section.
6. Launch InfluxDB on each node.

> **Warning:** If you're having a hard time setting up your cluster, try settings the `/var/opt/influxdb/meta/peers.json` file to be `["<hostname 1>:<bind-address 1>","<hostname 2>:<bind-address 2>","<hostname 3>:<bind-address 1>"]`.

#### Add More Nodes

1. Install InfluxDB on the new node.
2. In the `/etc/init.d/influxdb` file, set `INFLUXD_OPTS="-join <hostname 1>:<bind-address 1>,<hostname 2>:<bind-address 2>,<hostname 3>:<bind-address 3>`.
3. Launch Influxdb on the node.

To verify that each node has successfully joined the cluster, issue a `show server` query to one of the nodes in the cluster.

