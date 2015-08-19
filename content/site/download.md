+++
title = "downloads"
layout = "sidebar"
+++
# InfluxDB Downloads

## Version 0.9.2 (Stable)

#### OS X

- Via [Homebrew](http://brew.sh/)

		brew update
		brew install influxdb

#### Ubuntu & Debian

- 64-bit system install instructions

		wget https://s3.amazonaws.com/influxdb/influxdb_0.9.2_amd64.deb
		sudo dpkg -i influxdb_0.9.2_amd64.deb

#### RedHat & CentOS

- 64-bit system install instructions

		wget https://s3.amazonaws.com/influxdb/influxdb-0.9.2-1.x86_64.rpm
		sudo yum localinstall influxdb-0.9.2-1.x86_64.rpm


## Version 0.9.3 (Release Candidate)
Release candidates are made available for testing one week prior to release of the stable point release.

### Ubuntu & Debian

- 64-bit system install instructions

        wget https://s3.amazonaws.com/influxdb/influxdb_0.9.3-rc1_amd64.deb
        sudo dpkg -i influxdb_0.9.3-rc1_amd64.deb

### RedHat & CentOS

- 64-bit system install instructions

        wget https://s3.amazonaws.com/influxdb/influxdb-0.9.3_rc1-1.x86_64.rpm
        sudo rpm -ivh influxdb-0.9.3_rc1-1.x86_64.rpm

## Version 0.9.4 (Nightly)
Nightly builds are created once-a-day using the top-of-tree of [master](https://github.com/influxdb/influxdb/tree/master) source code. These builds will include all the latest fixes, but also undergo only basic testing.

#### Ubuntu & Debian

- 64-bit system install instructions

        wget https://s3.amazonaws.com/influxdb/influxdb_nightly_amd64.deb
        sudo dpkg -i influxdb_nightly_amd64.deb

#### RedHat & CentOS

- 64-bit system install instructions

        wget https://s3.amazonaws.com/influxdb/influxdb-nightly-1.x86_64.rpm
        sudo yum localinstall influxdb-nightly-1.x86_64.rpm


### Deprecated Releases

Deprecated versions are no longer actively developed.

- [version 0.8](/docs/v0.8/introduction/installation.html)


# Telegraf Downloads

## Version 0.1.4

#### OS X

- Via [Homebrew](http://brew.sh/)

		brew update
		brew install telegraf

#### Ubuntu & Debian

- 64-bit system install instructions

		wget http://get.influxdb.org/telegraf/telegraf_0.1.4_amd64.deb
		sudo dpkg -i telegraf_0.1.4_amd64.deb

#### RedHat & CentOS

- 64-bit system install instructions

		wget http://get.influxdb.org/telegraf/telegraf-0.1.4-1.x86_64.rpm
		sudo yum localinstall telegraf-0.1.4-.x86_64.rpm

