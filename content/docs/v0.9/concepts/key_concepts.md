---
title: Key Concepts
---

Before diving into InfluxDB it's good to get acquainted with some of the key concepts of the database. This document provides a gentle introduction to those concepts and common InfluxDB terminology. We've provided a list below of all the terms we'll cover, but we recommend reading this document chronologically to gain a more general understanding of your favorite timeseries database. 
 
[database](../concepts/key_concepts.html#database)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[field key](../concepts/key_concepts.html#field-key)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[field set](../concepts/key_concepts.html#field-set)  
[field value](../concepts/key_concepts.html#field-value)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[measurement](../concepts/key_concepts.html#measurement)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[point](../concepts/key_concepts.html#point)  
[retention policy](../concepts/key_concepts.html#retention-policy)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[series](../concepts/key_concepts.html#series)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[tag key](../concepts/key_concepts.html#tag-key)  
[tag set](../concepts/key_concepts.html#tag-set)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[tag value](../concepts/key_concepts.html#tag-value)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[timestamp](../concepts/key_concepts.html#timestamp)  

Check out the [Glossary](../concepts/glossary.html) if you prefer the cold, hard facts.

### Sample data
The next section references the data printed out below. The data are fictional, but represent a believable setup in InfluxDB. Assume that the data live in a database called, rather uninterestingly, `my_database` and are subject to the `default` retention policy (more on databases and retention policies to come). 

*Hint:* Hover over the links to briefly get acquainted with InfluxDB terminology and the layout. It's probably best not to click on them unless you're already somewhat familiar with InfluxDB.

👀 I like the idea of being able to see the location of the measurement, tags, fields, etc. in a standard data output. I couldn't figure out a better way to do this in markdown - is my method kind of annoying or do you think it offers some useful information? 👀

name: [count](../concepts/key_concepts.html#measurement "Measurement")  
\-------------------------------------  
time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[butterflies](../concepts/key_concepts.html#field-key "Field key")&nbsp;&nbsp;&nbsp;[honeybees](../concepts/key_concepts.html#field-key "Field key")&nbsp;&nbsp;&nbsp;[location](../concepts/key_concepts.html#tag-key "Tag key")&nbsp;&nbsp;&nbsp;&nbsp;[scientist](../concepts/key_concepts.html#tag-key "Tag key")  
2015-08-18T00:00:00Z&nbsp;&nbsp;&nbsp;12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;23&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;langstroth  
2015-08-18T00:00:00Z&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;perpetua  
2015-08-18T00:06:00Z&nbsp;&nbsp;&nbsp;11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;28&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;langstroth  
[2015-08-18T00:06:00Z](../concepts/key_concepts.html#timestamp "Timestamp")&nbsp;&nbsp;&nbsp;[3](../concepts/key_concepts.html#field-value "Field value")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[28](../concepts/key_concepts.html#field-value "Field value")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1](../concepts/key_concepts.html#tag-value "Tag value")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[perpetua](../concepts/key_concepts.html#tag-value "Tag value")  
2015-08-18T05:54:00Z&nbsp;&nbsp;&nbsp;2&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;langstroth  
2015-08-18T06:00:00Z&nbsp;&nbsp;&nbsp;1	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;langstroth  
2015-08-18T06:06:00Z&nbsp;&nbsp;&nbsp;8	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;23&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;perpetua  
2015-08-18T06:12:00Z&nbsp;&nbsp;&nbsp;7	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;22	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;perpetua  

### Discussion
Now that you've seen some sample data in InfluxDB this section covers [what it all means](https://www.youtube.com/watch?v=I5cYgRnfFDA).

InfluxDB is a timeseries database so it makes sense to start with what is at the root of everything we do: time. In the data above there's a column called `time` - all data in InfluxDB have that column. `time` stores timestamps, and the <a name="timestamp"></a>**timestamp** records the date and time, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) UTC, associated with particular data.

A <a name="field-value"></a>**field value** is the value part of the key-value pair that makes up a field. Simply put, field values are your data; they can be strings, floats, integers, or booleans, and, because InfluxDB is a timeseries database, a field value is always associated with a timestamp. In the data above the field values are:

```
12   23
1    30
11   28
3    28
2    11
1    10
8    23
7    22
```

The key part of the key-value pair that makes up a field is called the <a name="field-key"></a> **field key**. Field keys are strings and they store metadata; the field key `butterflies` tells us that the field values `12`-`7` refer to butterflies and the field key `honeybees` tells us that the field values `23`-`22` refer to, well, honeybees. 

Fields are a required piece of InfluxDB's data structure - you cannot have data in InfluxDB without fields. It's also important to note that fields are not indexed - [queries](../concepts/glossary.html#query) on fields scan all points that match the specified time range in the query and, as a result, are not performant. Because of this, the metadata stored in the field keys should not contain commonly-queried metadata. We'll cover where to store commonly-queried metadata later.

In the data above, the field-key and field-value pairs with the same timestamp make up a <a name="field-set"></a>**field set**. Here are all eight field sets in the sample data:

* `butterflies = 12   honeybees = 23`
* `butterflies = 1    honeybees = 30`
* `butterflies = 11   honeybees = 28`
* `butterflies = 3    honeybees = 28`
* `butterflies = 2    honeybees = 11`
* `butterflies = 1    honeybees = 10`
* `butterflies = 8    honeybees = 23`
* `butterflies = 7    honeybees = 22`

👀 Is this an OK simplification? To get the formal definition of a field set they'd need to know what a point is and I don't want to get into series until they know what measurements, tag sets, and retention policies are. 👀

As we mentioned earlier, commonly queried metadata don't belong in fields because fields aren't indexed. Tags, on the other hand, are indexed - this means that queries on tags are fast and that tags are ideal for storing commonly-queried metadata.  A tag is made up of a <a name="tag-key"></a>**tag key** and a <a name="tag-value"></a>**tag value**. Both tag keys and tag values are stored as strings. Tags are also optional; you don't need to have tags in your data, but it's generally a good idea to make use of them.

The tag keys in the sample data are `location` and `scientist`. The tag key `location` has two tag values: `1` and `2`. The tag key `scientist` also has two tag values: `langstroth` and `perpetua`.

In the data above, the <a name="tag-set"></a>**tag set** is the different combinations of all the tag key-value pairs that have the same timestamp. The four tag sets in the sample data are:

* `location = 1`, `scientist = langstroth`
* `location = 2`, `scientist = langstroth`
* `location = 1`, `scientist = perpetua`
* `location = 2`,  `scientist = perpetua`

👀Same simplification issue as before, see the field set question. 👀

> **Why indexing matters: The schema case study**  

> Say you notice that most of your queries focus on the field keys `honeybees` and `butterflies` instead of focusing on the tag key `scientist`. To make your queries performant, it may be beneficial to rearrange your [schema](../concepts/glossary.html#schema) such that the tag values of `scientist` (`langstroth` and `perpetua`) become field keys and a new tag key (`pollinator`) has the tag values `honeybees` and `butterflies`:

> name: [count](../concepts/key_concepts.html#measurement "Measurement")  
\-------------------------------------  
time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[langstroth](../concepts/key_concepts.html#field-key "Field key")&nbsp;&nbsp;[perpetua](../concepts/key_concepts.html#field-key "Field key")&nbsp;&nbsp;[location](../concepts/key_concepts.html#tag-key "Tag key")&nbsp;&nbsp;[pollinator](../concepts/key_concepts.html#tag-key "Tag key")                                
2015-08-18T00:00:00Z&nbsp;&nbsp;&nbsp;12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;butterflies  
2015-08-18T00:00:00Z&nbsp;&nbsp;&nbsp;23&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;honeybees  
2015-08-18T00:06:00Z&nbsp;&nbsp;&nbsp;11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;butterflies  
[2015-08-18T00:06:00Z](../concepts/key_concepts.html#timestamp "Timestamp")&nbsp;&nbsp;&nbsp;[28](../concepts/key_concepts.html#field-value "Field value")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[28](../concepts/key_concepts.html#field-value "Field value")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1](../concepts/key_concepts.html#tag-value "Tag value")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[honeybees](../concepts/key_concepts.html#tag-value "Tag value")  
2015-08-18T05:54:00Z&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;butterflies  
2015-08-18T05:54:00Z&nbsp;&nbsp;&nbsp;11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;honeybees  
2015-08-18T06:00:00Z&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;butterflies  
2015-08-18T06:00:00Z&nbsp;&nbsp;&nbsp;10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;honeybees  
2015-08-18T06:06:00Z &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;butterflies  
2015-08-18T06:06:00Z&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;23&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;honeybees  
2015-08-18T06:12:00Z&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;butterflies  
2015-08-18T06:12:00Z&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;honeybees  

> Now your queries on the tag values `honeybees` and `butterflies` are performant.

The <a name=measurement></a>**measurement** is the unit of the data that are stored in the associated fields. Measurements are strings, and, for any SQL users out there, a measurement is similar to a table. The only measurement in the sample data is `count`. `count` tells us that field values are the number of `butterflies` and `honeybees` - not some sort of happiness index.

A single measurement can belong to different retention policies. A <a name="retention-policy"></a>**retention policy** describes how long a InfluxDB keeps data (`DURATION`) and how many copies of those data are stored in the cluster (`REPLICATION`). If you're interested in reading more about retention policies, check out [Database Management](../query_language/database_management.html#retention-policy-management). 

In the sample data, everything in the `count` measurement belongs to the `default` retention policy. InfluxDB automatically creates that retention policy; it has an infinite duration and a replication factor of one.

Now that you're familiar with measurements, tag sets, and retention policies it's time to discuss series. In InfluxDB, a <a name=series></a> **series** is the collection of data that share a measurement, tag set, and retention policy. The data above consist of four series:

| Arbitrary series number  |  Measurement | Tag set  |  Retention policy |
|---|---|---|---|
| series 1  | `count` | `location = 1`,`scientist = langstroth`  | `default` |
| series 2 | `count`  |  `location = 2`,`scientist = langstroth` |  `default` |
| series 3  | `count` | `location = 1`,`scientist = perpetua`  | `default` |
| series 4 | `count`  |  `location = 2`,`scientist = perpetua` |  `default` |

Understanding the concept of a series is essential when designing your schema and when working with your data in InfluxDB.

Finally, a <a name="point"></a>**point** is the field set in the same series with the same timestamp. So, for the series where the measurement is `count`; the tag set is `location = 1`,`scientist = perpetua`; and the retention policy is `default`, and for the timestamp `2015-08-18T00:00:00Z`, the point is:
```
butterflies honeybees      
1           30
``` 

All of the stuff we've just covered is stored in a database - the sample data are in the database `my_database`. An InfluxDB <a name=database></a> **database** is similar to a traditional relational databases and serves as a logical container for users, retention policies, continuous queries, and, of course, your time series data. Please forgive us for skipping over [users](../administration/authentication_and_authorization.html) and [continuous queries](../query_language/continuous_queries.html) - those links will take better care of you if you're interested in learning more.

Databases can have several users, continuous queries, retention policies, and measurements. InfluxDB is a schemaless database which means it's easy to add new measurements, tags, and fields at any time. It's designed to make working with time series data awesome.

You made it! You've covered the fundamental concepts and terminology in InfluxDB. If you're just starting out, we recommend taking a look at [Getting Started](../introduction/getting_started.html) and the [Writing Data](../guides/writing_data.html) and [Querying Data](../guides/querying_data.html) guides. May our timeseries database serve you well 🕔. 
 



