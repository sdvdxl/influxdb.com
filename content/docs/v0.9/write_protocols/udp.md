---
title: Service - UDP
---

InfluxDB provides an easy way to use UDP as an input source.

## Config File

In your config file you specify the database for the point that will be written to, and the port that it will listen for it on.

```
...

[[udp]]
  enabled = true
  bind-address = ":8089"
  database = "foo"
  batch-size = 1000
  batch-timeout = “1s”

...
```

You can listen for data on multiple ports and databases.

```
...

[[udp]]
  enabled = true
  bind-address = ":8089"
  database = "foo"
  batch-size = 1000
  batch-timeout = “1s”

[[udp]]
  enabled = true
  bind-address = ":4444"
  database = "bar"
  batch-size = 1000
  batch-timeout = “1s”

...
```

## Writing Points

To write, just send newline separated line protocol over UDP.  Can send one point at a time (not very performant) or send batches.

```bash
$ echo "cpu value=1"> /dev/udp/localhost/8089
```
