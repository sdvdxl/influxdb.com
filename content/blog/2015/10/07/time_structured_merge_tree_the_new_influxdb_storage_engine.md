+++
title = "The new InfluxDB storage engine: a Time Structured Merge Tree"
author = "Paul Dix"
date = "2015-10-07"
publishdate = "2015-10-07"
+++

For more than a year we've been talking about potentially making a storage engine purpose built for our use case of time series data. Today I'm excited to announce that we have the first version of our new storage engine available in a nightly build for testing. We're calling it the Time Structured Merge Tree or TSM Tree for short.

In our early testing we've seen up to a 45x improvement in disk space usage over 0.9.4 and we've written 10,000,000,000 (10B) data points (divded over 100k unique series) at a sustained rate greater than 300,000 per second on an EC2 c3.8xlarge instance. This new engine uses up to 98% less disk space to store the same data as 0.9.4 with no reduction in query performance. In this post I'll talk a little bit about the new engine and give pointers to more detailed writups and instructions on how to get started with testing the new storage engine.

The new storage engine has a number of advantages over our previous storage. It's a columnar format, which means that having multiple fields won't negatively affect query performance. For this engine we've also lifted the limitation on the number of fields you can have in a measurement.

It uses multiple compression techniques which vary depending on the data type of the field and the precision of the timestamps. Double delta encoding for timestamps and integers, the same delta encoding for floats mentioned in [Facebook's Gorilla paper](http://www.vldb.org/pvldb/vol8/p1816-teller.pdf), bits for booleans, and Snappy compression for strings. Depending on the shape of your data, the total size for storage including all tag metadata can range from 2 bytes per point on the low end to higher up for more random data. We found that random floats with second level precision in series sampled every 10 seconds take about 3 bytes per point. Real world data will probably look a bit better since there are often repeated values or small deltas.