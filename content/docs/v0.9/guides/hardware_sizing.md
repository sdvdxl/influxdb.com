---
title: Hardware Sizing Guidelines
aliases:
  - /docs/v0.9/guides/hardware_sizing.html
---

InfluxDB is a high performance database optimized for time series, but like any software its performance is affected by the hardware running it. Below are some recommendations for how to optimize your InfluxDB instance and understand which performance limitations are hardware related and which are software related. Below is a general list of hardware recommendations from the InfluxDB team.

| Load | Writes/Second | Queries/Second | Unique Series |
|----|--------------|------|---------|
|  Low |  < 10K |  < 5 |  100k |
|  Moderate |  < 200k |  < 25 |  < 1MM |
|  High |  > 200k |  > 25 |  > 1MM |
|  Infeasible |  > 750k |  > 100 |  > 20MM |

## Do I need more RAM?

RAM will help queries return faster. More is generally better, and there is no known downside to adding more RAM.

The major consideration affecting RAM needs is series cardinality. Using generated integers, floats, or random strings as tags can easily lead to large numbers of series and should be avoided. For example if a measurement has two tags with 10,000 possible values each the series cardinality would be 100M. This is enough to make even large machines experience OOM failures. Though proper schema design this problem can usually be mitigated. 

For series cardinality above 100k machines should have at least 4GB of RAM. If series cardinality is ~1 million the instance should have at least 16GB RAM. For cardinality approaching 10 million series the instance should have 64GB RAM or more. The increase in RAM needs is exponential, although the exponent is between 1 and 2. 

![Series Cardinality](/static/img/series-cardinality.png)

## Do I need more CPU?

When running a cluster no member should have less than 2 cores. For a single node instance, a single CPU core can function for low loads. 



## Do I need more IOPS?

InfluxDB is made to be run on SSDs.  Performance is drastically lower on spinning disk drives.

At least 500+ IOPS disk


## How much storage do I need?

For the tsm1 engine, numeric values take up about 3 bytes. String values take variable space as determined by string compression.

Database names, measurements, tag keys, field keys, and all tag values are stored once and only once, as strings. There is no meaningful storage overhead to them. Only field values and timestamps are stored per-point.

How should I configure my hardware?

When running InfluxDB in a production environment the /wal and /data directories should all be housed on separate mounted volumes. This prevents contention when the system is under heavy write load, which is the time when the write load to /data and /wal is the highest.

/wal can be on spinning disk, IOPS are most important for /data

What config settings matter?


How should I shape/submit my data?




What about clustering?

Put /hh on a separate volume, too. 
1000+ IOPS disks
at least 2 CPUs, at least 4GB RAM
best 4 CPUs and 8GB RAM



