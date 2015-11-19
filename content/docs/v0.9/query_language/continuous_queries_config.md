---
title: Configuring continuous queries
---

A continuous query (CQ) is an automated query that executes over recent time intervals. When InfluxDB executes a CQ it computes the query for the current `GROUP BY time()` interval (determined by `now()`) and it computes the query for previous `GROUP BY time()` intervals.

The rate at which InfluxDB executes a CQ and the number of previous time intervals that InfluxDB queries depend on the CQ's `GROUP BY time()` interval and on the following configuration options (shown with their default settings):

* `compute-runs-per-interval = 10`
* `compute-no-more-than = "2m0s"`
* `recompute-previous-n =  2`
* `recompute-no-older-than = "10m0s"`

InfluxDB compares `compute-runs-per-interval` and `compute-no-more-than` to determine the rate at which it executes a CQ. Under the first setting, InfluxDB executes the CQ `10` times per the `GROUP BY time()` interval. Under the second setting, InfluxDB executes the CQ every `2` minutes; this is the minimum rate at which InfluxDB executes a CQ.

InfluxDB compares `recompute-previous-n` and `recompute-no-older-than` to determine the number of previous intervals it queries when it executes a CQ. Under the first setting, InfluxDB queries `2` previous intervals. Under the second setting, InfluxDB queries all previous intervals within `now()` - `10` minutes. InfluxDB queries the smaller of the two options when it executes a CQ.

Depending on your CQ's `GROUP BY time()` interval you may want to make changes to the default configuration settings. The next sections present example CQs and discuss how they work with the configuration options:

* [CQ 1](../query_language/continuous_queries_config.html#cq-1-4-minute-group-by-time-interval) is an introductory example CQ that shows how the default configuration settings work with a CQ's `GROUP BY time()` interval. 
* [CQ 2](../query_language/continuous_queries_config.html#cq-2-30-second-group-by-time-interval) is an example of a CQ with a shorter term `GROUP BY time()` interval that doesn't work well with the default configuration settings. This section also covers how to alter the configuration settings to fix the issue.
* [CQ 3](../query_language/continuous_queries_config.html#cq-3-1-hour-group-by-time-interval) is an example of a CQ with a longer term `GROUP BY time()` interval. This section shows how to alter the configuration settings to take into account lagged data.

## CQ 1: 4 minute `GROUP BY time()` interval
### The default CQ schedule
Default configuration settings:  
`compute-runs-per-interval = 10`  
`compute-no-more-than = "2m0s"`  
`recompute-previous-n = 2`  
`recompute-no-older-than = "10m0s"`  

*InfluxDB executes CQ 1 every 2 minutes.*

InfluxDB compares `compute-runs-per-interval` and `compute-no-more-than` to determine the rate at which it executes CQ 1. Under `compute-runs-per-interval`, InfluxDB executes CQ 1 every `0.4` minutes (`4m`/`10`). Under `compute-no-more-than`, InfluxDB executes the CQ every `2` minutes. Because `compute-no-more-than` is the minimum rate at which InfluxDB executes a CQ, CQ 1 runs every `2` minutes.

*InfluxDB computes queries for 2 previous intervals in addition to computing the query for the current time interval.*

InfluxDB compares `recompute-previous-n` and `recompute-no-older-than` to determine the number of previous intervals it queries when it executes CQ 1. Under `recompute-previous-n`, InfluxDB queries `2` previous intervals. Under `recompute-no-older-than`, InfluxDB queries, at most, `3`<sup>[*](#note1)</sup> previous intervals (`10m0s`/`4m` = `2.5`). InfluxDB queries the smaller of the two options when it executes CQ 1.

> <a name="note1"></a>**Note:** InfluxDB rounds up to the next complete interval if the `GROUP BY time()` interval doesn't divide evenly into `recompute-no-older-than`.

## CQ 2: 30 second `GROUP BY time()` interval
### The default CQ schedule
Default configuration settings:  
`compute-runs-per-interval = 10`  
`compute-no-more-than = "2m0s"`  
`recompute-previous-n = 2`  
`recompute-no-older-than = "10m0s"`  

*InfluxDB executes CQ 2 every 2 minutes.*

InfluxDB compares `compute-runs-per-interval` and `compute-no-more-than` to determine the rate at which it executes CQ 2. Under `compute-runs-per-interval`, InfluxDB executes CQ 2 every `3` seconds (`30s`/`10`). Under `compute-no-more-than`, InfluxDB executes the CQ every `2` minutes. Because `compute-no-more-than` is the minimum rate at which InfluxDB executes a CQ, CQ 2 runs every `2` minutes.

*InfluxDB computes queries for 2 previous intervals in addition to computing the query for the current time interval.*

InfluxDB compares `recompute-previous-n` and `recompute-no-older-than` to determine the number of previous intervals it queries when it executes CQ 2. Under `recompute-previous-n`, InfluxDB queries `2` previous intervals. Under `recompute-no-older-than`, InfluxDB queries, at most, `20` previous intervals (`600s`/`30s` = `20`). InfluxDB queries the smaller of the two options when it executes CQ 2.

#### The missing interval problem
Because of CQ 2's small `GROUP BY time()` interval, leaving the default configuration settings as is causes InfluxDB to miss intervals. 

Assume CQ 2 begins running at midnight. InfluxDB computes the query for the following three time intervals:  
Current interval: `00:00:00` - `00:00:30`  
Previous interval 1: `00:59:30` - `00:00:00`  
Previous interval 2: `00:59:00` - `00:59:30`  

Two minutes later, InfluxDB executes the query for the following three time intervals:  
Current interval: `00:02:00` - `00:02:30`  
Previous interval 1: `00:01:30` - `00:02:00`  
Previous interval 2: `00:01:00` - `00:01:30`

Notice that InfluxDB never executes the query for the time interval from `00:00:30` through `00:01:00`. The next two sections offer different ways to solve the missing interval problem.

### Change the execution rate
New configuration settings:  
`compute-runs-per-interval = 10`  
`compute-no-more-than = "1m30s"`  

*InfluxDB now executes CQ 2 every 1.5 minutes.*

InfluxDB compares `compute-runs-per-interval` and `compute-no-more-than` to determine the rate at which it executes CQ 2. Under `compute-runs-per-interval`, InfluxDB executes CQ 2 every `3` seconds (`30s`/`10`). Under `compute-no-more-than`, InfluxDB executes the CQ every `1.5` minutes. Because `compute-no-more-than` is the minimum rate at which InfluxDB executes a CQ, CQ 2 runs every `1.5` minutes.

The new configuration settings prevent InfluxDB from missing intervals by increasing the frequency at which CQ 2 runs from every `2` minutes to every `1.5` minutes. Assuming CQ 2 begins running at midnight,  InfluxDB computes the query for the following three time intervals:  
Current interval: `00:00:00` - `00:00:30`  
Previous interval 1: `00:59:30` - `00:00:00`  
Previous interval 2: `00:59:00` - `00:59:30`  

`1.5` minutes later, InfluxDB computes the query for the following three time intervals:  
Current interval: `00:01:30` - `00:02:00`  
Previous interval 1: `00:01:00` - `00:01:30`  
Previous interval 2: `00:00:30` - `00:01:00`

Notice that InfluxDB now computes the query for the time interval from `00:00:30` through `00:01:00`.

### Change the number of previous intervals queried
New configuration settings:    
`recompute-previous-n = 3`  
`recompute-no-older-than = "10m0s"`  

*InfluxDB now computes queries for 3 previous intervals in addition to computing the query for the current time interval.*

InfluxDB compares `recompute-previous-n` and `recompute-no-older-than` to determine the number of previous intervals it queries when it executes CQ 2. Under `recompute-previous-n`, InfluxDB queries `3` previous intervals. Under `recompute-no-older-than`, InfluxDB queries, at most, `20` previous intervals (`600s`/`30s` = `20`). InfluxDB queries the smaller of the two options when it executes CQ 2.

The new settings prevent InfluxDB from missing intervals by increasing the number of intervals it computes from `2` to `3`. Assuming CQ 2 begins running at midnight,  InfluxDB computes the query for the following four time intervals:  
Current interval: `00:00:00` - `00:00:30`  
Previous interval 1: `00:59:30` - `00:00:00`  
Previous interval 2: `00:59:00` - `00:59:30`  
Previous interval 3: `00:58:30` - `00:59:00`  

`2` minutes later, InfluxDB executes the query for the following four time intervals:  
Current interval: `00:02:00` - `00:02:30`  
Previous interval 1: `00:01:30` - `00:02:00`  
Previous interval 2: `00:01:00` - `00:01:30`  
Previous interval 2: `00:00:30` - `00:01:00`  

Notice that InfluxDB now computes the query for the time interval from `00:00:30` through `00:01:00`.

## CQ 3: 1 hour `GROUP BY time()` interval
### The default CQ schedule
Default configuration settings:   
`compute-runs-per-interval = 10`  
`compute-no-more-than = "2m0s"`  
`recompute-previous-n = 2`  
`recompute-no-older-than = "10m0s"`  

*InfluxDB executes CQ 3 every 6 minutes.*

InfluxDB compares `compute-runs-per-interval` and `compute-no-more-than` to determine the rate at which it executes CQ 3. Under `compute-runs-per-interval`, InfluxDB executes the CQ every `6` minutes (`60m`/`10`). Under `compute-no-more-than`, InfluxDB executes the CQ every `2` minutes. Because the execution rate under `compute-runs-per-interval` is greater than that under `compute-no-more-than`, CQ 3 runs every `6` minutes.

*InfluxDB computes queries for, at most, 1 previous interval in addition to computing the query for the current time interval.*

InfluxDB compares `recompute-previous-n` and `recompute-no-older-than` to determine the number of previous intervals it queries when it executes CQ 3. Under `recompute-previous-n`, InfluxDB queries `2` previous intervals. Under `recompute-no-older-than`, InfluxDB queries, at most, `1`<sup>[*](#note2)</sup> previous interval (`10m0s`/`60m` = `0.167`). InfluxDB queries the smaller of the two options when it executes CQ 3.

> <a name="note2"></a>**Note:** InfluxDB rounds up to the next complete interval if the `GROUP BY time()` interval doesn't divide evenly into `recompute-no-older-than`.

#### The lagged data problem
InfluxDB computes one previous interval if `now()` - `10` minutes falls in the previous interval. 

If CQ 3 runs at `13:58:00` InfluxDB computes the query for all data between `13:00:00` and `14:00:00`. It does not compute the query for the previous interval (`12:00:00` - `13:00:00`) because `13:48:00` (`13:58:00` - `10` minutes) does not fall in that interval.

InfluxDB executes CQ 3 six minutes later at `14:04:00`. It computes the query for the current time interval (`14:00:00` - `15:00:00`) and for one previous time interval (`13:00:00` - `14:00:00`). It computes the query for the previous time interval because `13:54:00` (`14:04:00` - `10` minutes) falls in the previous interval.

At `14:10:00`, InfluxDB executes CQ 3 and computes the query for the current time interval (`14:00:00` - `15:00:00`). It does not compute the query for the previous time interval because `14:00:00` (`14:10:00` - `10` minutes) does not fall in the previous interval.

If you have lagged data, computing, at most, `1` previous interval may not take into account all of your data. See the next section for how to adjust the configuration settings so that InfluxDB always computes the query for the previous time interval when it executes CQ 3.

### Change the number of previous intervals queried
New configuration settings:  
`recompute-previous-n = 1`  
`recompute-no-older-than = 120m0s`  

*InfluxDB always computes the query for 1 previous interval in addition to computing the query for the current time interval.*

InfluxDB compares `recompute-previous-n` and `recompute-no-older-than` to determine the number of previous intervals it queries when it executes CQ 3. Under `recompute-previous-n`, InfluxDB queries `1` previous interval. Under `recompute-no-older-than`, InfluxDB queries, at most, `2` previous intervals (`120m0s`/`60m` = `2`). InfluxDB queries the smaller of the two options when it executes CQ 3.

The new settings ensure that InfluxDB always computes the query for the current time interval and for one previous time interval.



