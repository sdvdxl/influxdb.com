---
title: Package Repository for Linux
author: Ross McDonald
date: 2015-12-04
publishdate: 2015-12-04
---

Today we are officially announcing the InfluxData package repository. This package repository can be used with Ubuntu, Debian, RedHat, and CentOS Linux package management systems, with more distributions and operating systems coming soon. You will now be able to automatically download and install the latest InfluxData releases as they become available. In addition, all releases are GPG-signed, ensuring that all packages are verified and secure before installation.

## Configuring

To get started, follow the instructions below for your Linux distribution of choice:

### CentOS Users

Currently CentOS 6 and 7 are the only supported versions. To add the InfluxData repository, copy and paste the following into a terminal as an administrator/root user:

```
cat <<EOF>/etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - CentOS \$releasever
baseurl = https://repos.influxdata.com/centos/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
```

Once the InfluxData repository has been added, you can install the latest stable release of InfluxDB using the following commands:

```
yum install influxdb
```

And to remove InfluxDB:

```
yum remove influxdb
```

### RedHat Enterprise Linux Users

As with CentOS, only RHEL 6 and 7 are currently supported. To add the InfluxData repository, copy and paste the following into a terminal as an administrator/root user:

```
cat <<EOF>/etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
```

Once the InfluxData repository has been added, you can install the latest stable release of InfluxDB using the following commands:

```
yum install influxdb
```

And to remove InfluxDB:

```
yum remove influxdb
```

### Ubuntu Users

For Ubuntu, versions 12.04 (Precise), 14.04 (Trusty), 14.10 (Utopic), and 15.04 (Vivid) are currently supported. To add the InfluxData repository, copy and paste the following into a terminal as an administrator/root user:

```
curl -sL https://repos.influxdata.com/influxdb.key | apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | tee -a /etc/apt/sources.list
```

Once the InfluxData repository has been added, you can install the latest stable release of InfluxDB using the following commands:

```
apt-get update
apt-get install influxdb
```

And to remove InfluxDB:

```
apt-get remove influxdb
```

### Debian Users

For Debian, Jessie and Wheezy are the currently supported releases. To add the InfluxData repository, copy and paste the following into a terminal as an administrator/root user:

```
curl -sL https://repos.influxdata.com/influxdb.key | apt-key add -
source /etc/os-release
test $VERSION_ID = "7" && echo "deb https://repos.influxdata.com/debian wheezy stable" | tee -a /etc/apt/sources.list
test $VERSION_ID = "8" && echo "deb https://repos.influxdata.com/debian jessie stable" | tee -a /etc/apt/sources.list
```

Once the InfluxData repository has been added, you can install the latest stable release of InfluxDB using the following commands:

```
apt-get update
apt-get install influxdb
```

And to remove InfluxDB:

```
apt-get remove influxdb
```

## What's Next

And that’s it! Once the configuration above is applied, your system will automatically be able to install and upgrade to current and future stable versions of InfluxDB (and other InfluxData applications) as they are released. Of course if you run into any issues at all, please don’t hesitate to contact us at [support@influxdb.com](mailto://support@influxdb.com).

*Don’t see your distribution listed here? Create an [issue](https://github.com/influxdb/influxdb/issues/new) on Github, and we’ll try our best to get it added the repository.*
