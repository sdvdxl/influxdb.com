---
title: Clustering
aliases:
  - /docs/v0.9/guides/clustering.html
  - /docs/v0.9/concepts/clustering.html

---

> **Note:** Clustering is still in a beta state right now. There are still a good number of rough edges. If you notice any issues please [report them](https://github.com/influxdb/influxdb/issues/new).

In 0.9.1 and 0.9.2 clusters are restricted 3 nodes and must be fully replicated, meaning all data is copied to all nodes and retention policies must have replication set to 3 for all three nodes in the cluster.

Starting with version 0.9.3, Influxdb supports arbitrarily sized clusters that need not be fully replicated. Additionally new data nodes can be added to a cluster. The first three nodes to join a cluster are raft `peers`. All subsequent nodes are data nodes and do not participate in consensus. See Pull Request [#3478](https://github.com/influxdb/influxdb/pull/3478) for more information.

## Configuration
The following is the current recommended procedure for configuring a cluster. While it is still possible to configure your cluster using `peers` in the `[meta]` section of your config file, we encourage the use of the `-join` flag instead.

> **Note:** In versions 0.9.1 and 0.9.2, a cluster needs to be configured by specifying peers. If you plan on using clustering it is highly recommended that you upgrade to version 0.9.3+.

### Start the Initial Raft Cluster

Throughout this example, each node will be given a number that denotes the order in which it was started (e.g. 1 for the first node, 2 for the second node, etc). It is also assumed that you are running some version of Linux and while it is possible to build a cluster locally, it is not recommended.

1. Install InfluxDB on the 3 machines.
2. For each node's `/etc/opt/influxdb/influxdb.conf` file, replace `hostname = "localhost"` with your host's actual name.
3. For each node's `/etc/opt/influxdb/influxdb.conf` file, update the `bind-address` to another port if `8088` is unacceptable.
4. Start InfluxDB on the first node. Note that the `bind-address` may differ from node to node (e.g. one can use 8088, another use 9099, and the other 10101).
5. In `/etc/init.d/influxdb` on the second node, set `INFLUXD_OPTS="-join hostname_1:bind-address_1"`.
6. Start InfluxDB on the second node.
7. In `/etc/init.d/influxdb` on the third node, set `INFLUXD_OPTS="-join hostname_1:bind-address_1,hostname_2:bind-address_2"`.
8. Start InfluxDB on the third node.

At this point you'll want to verify that that your initial raft cluster is healthy. To do this, issue a `SHOW SERVERS` query to each node in your raft cluster. You should see something along the lines of this:

| id | cluster_addr | raft |
|----|--------------|------|
|  1 | "hostname_1:bind-address_1" |  true |
|  2 | "hostname_2:bind-address_2" |  true |
|  3 | "hostname_3:bind-address_3" |  true |

If you do not see all three raft nodes, your cluster is not healthy.

> **Warning:** If you're having a hard time setting up your cluster, try setting the `/var/opt/influxdb/meta/peers.json` file manually to be `["<hostname 1>:<bind-address 1>","<hostname 2>:<bind-address 2>","<hostname 3>:<bind-address 1>"]` and `/var/opt/influxdb/meta/id` to be `1`, `2`, and `3` for each node respectively

### Add More Data Nodes

Once you have verified that your raft cluster is healthy and running appropriately, extra data nodes can be added.

1. Install InfluxDB on the new node.
2. In the new node's `/etc/opt/influxdb/influxdb.conf` file, replace `hostname = "localhost"` with the nodes hosts actual name.
3. In the new node's `/etc/opt/influxdb/influxdb.conf` file, update the `bind-address` to another port if `8088` is unacceptable.
2. In the new node's `/etc/init.d/influxdb` file, set `INFLUXD_OPTS="-join hostname_1:bind-address_1,hostname_2:bind-address_2"`.
3. Start InfluxDB on the new node.

> **Note:** When using the `-join` you need only specify one `hostname:bind-address` pair. However, if more than one is provided, Influx will try to connect with the additional pairs in the case that it cannot connect with the first one.

To verify that the new node has successfully joined the cluster, issue a `SHOW SERVERS` query to one of the nodes in the cluster. You should see something along the lines of this:

| id | cluster_addr | raft |
|----|:--------------:|------|
|  1 | "hostname_1:bind-address_1" |  true  |
|  2 | "hostname_2:bind-address_2" |  true  |
|  3 | "hostname_3:bind-address_3" |  true  |
| ...|        ...                  |  false |
|  n | "hostname_n:bind-address_n" |  false |

If you do not, then your node was not successfully added to the cluster.

> **Warning** Currently InfluxDB supports writes to any node in the cluster, however queries must be directed at one of the 3 raft peers. This is a bug. See issue [3574](https://github.com/influxdb/influxdb/issues/3574) for more information.

## Unimplemented Features

* Add new raft members - If you have a one node cluster, and add nodes, it should eventually add the first 3 nodes as part of the raft cluster. Configuring which nodes participate in raft consensus after the first three nodes form a cluster is not currently possible. For now, all new nodes are data-only nodes.
* If all the join addresses fail to join, the node will not retry need to be restarted to retry the join.
* Leader RPC retries - remote calls to the raft cluster use a random member from the set of peers.  If that member is down, the call will fail and return an error.  Many of these could be retried automatically. As a result, it may appear as if a cluster is unavailable, when it is actually only a single node that is failing.
* Removing nodes (raft or data-only).  
