---
title: Installation
---

This page provides directions on downloading and starting InfluxDB Version 0.9.3.

## Requirements
Installation of the pre-built InfluxDB package requires root privileges on the host machine.

### Networking
By default InfluxDB will use TCP ports `8083` and `8086` so these ports should be available on your system. Once installation is complete you can change those ports and other options in the configuration file, which is located by default in `/etc/opt/influxdb`.

## Ubuntu & Debian
Debian users can install 0.9.3 by downloading the package and installing it like this:

```bash
# 64-bit system install instructions
wget http://influxdb.s3.amazonaws.com/influxdb_0.9.3_amd64.deb
sudo dpkg -i influxdb_0.9.3_amd64.deb
```

Then start the daemon by running:

```sh
sudo /etc/init.d/influxdb start
```

## RedHat & CentOS
RedHat and CentOS users can install by downloading and installing the rpm like this:

```bash
# 64-bit system install instructions
wget http://influxdb.s3.amazonaws.com/influxdb-0.9.3-1.x86_64.rpm
sudo yum localinstall influxdb-0.9.3-1.x86_64.rpm
```

Then start the daemon by running:

```sh
sudo /etc/init.d/influxdb start
```

## OS X

Users of OS X 10.8 and higher can install using the [Homebrew](http://brew.sh/) package manager.

```sh
brew update
brew install influxdb
```

<a href="getting_started.html"><font size="6"><b>⇒ Now get started!</b></font></a>


## Hosted

For users who don't want to install any software and are ready to use InfluxDB, you may want to check out our [managed hosted InfluxDB offering](http://customers.influxdb.com).

## Generate a configuration file

Configuration files from prior versions of InfluxDB 0.9 should work with future releases, but the old files may lack configuration options for new features. It is a best practice to generate a new config file for each upgrade. Any changes made in the old file will need to be manually ported to the newly generated file. The newly generated configuration file has no knowledge of any local customization to the settings.

To generate a new config file, run `influxd config` and redirect the output to a file. For example:

```shell
/opt/influxdb/influxd config > /etc/influxdb/influxdb.generated.conf
```

Edit the `influxdb.generated.conf` file to have the desired configuration settings. When launching InfluxDB, point the process to the correct configuration file using the `-config` option.

```shell
/opt/influxdb/influxd -config /etc/influxdb/influxdb.generated.conf
```

In addition, a valid configuration file can be displayed at any time using the command `influxd config`. Redirect the output to a file to save a clean generated configuration file.

If no `-config` option is supplied, InfluxDB will use an internal default configuration equialent to the output of `influxd config`

> Note: The `influxd` command has two similarly named flags. The `config` flag prints a generated default configuration file to STDOUT but does not launch the `influxd` process. The `-config` flag takes a single argument, which is the path to the InfluxDB configuration file to use when launching the process.

The `config` and `-config` flags can be combined to output the union of the internal default configuration and the configuration file passed to `-config`. The options specificed in the configuration file will overwrite any internally generated configration.

```shell
/opt/influxdb/influxd config -config /etc/influxdb/influxdb.partial.conf
```

The output will show every option configured in the `influxdb.partial.conf` file and will substitute internal defaults for any configuration options not specified in that file.

The example configuration file shipped with the installer is for information only. It is an identical file to the internally generated configuration except that the example file has comments.




## Development Versions

Nightly packages are available and can be found on the [downloads page](/download/index.html)
