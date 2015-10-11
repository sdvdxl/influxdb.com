+++
title = "Announcing Windows Installation Packages for InfluxDB"
author = "Cory LaNou"
date = "2015-10-09"
publishdate = "2015-10-09"
+++

Today we are releasing our initial Windows install packages for [InfluxDB](https://influxdb.com/), [Telegraf](https://github.com/influxdb/telegraf),  and [Chronograf](https://influxdb.com/chronograf/).  These packages represent a minimal installation designed to get developers up and running quickly with local instances. Future releases will likely include the ability to:

* Install executables as a service
* Log to the Event Log instead of to stderr
* Allow for a customized configuration

The Windows Installer should work on any 64 bit version of Windows.

To download the latest installers, visit our [downloads page](https://influxdb.com/download/index.html).

### Installing InfluxDB

Installing InfluxDB consists of working through three simple screens.

1. Agree to the license
2. Install
3. Success!

![](/img/blog/windows/image10.png)

![](/img/blog/windows/image13.png)

![](/img/blog/windows/image07.png)

After the installation you will see a new folder in your Startup Menu called “InfluxDB”.  The following shortcuts are installed for your convenience:

* InfluxDB Server - Launches the InfluxDB database service.
* InfluxDB CLI - Launches the command line interface used to query and communicate with the InfluxDB server.
* Admin Dashboard - Opens the dashboard used to communicate with your InfluxDB database.
* Documentation - Links to the online documentation for InfluxDB.

![](/img/blog/windows/image15.png)

Launching the InfluxDB server you should see the following screen:
 
![](/img/blog/windows/image14.png)

Launching the InfluxDB CLI should result in the following screen:

![](/img/blog/windows/image17.png)

The InfluxDB CLI will automatically connect to your local InfluxDB instance if it is running.  The above example shows the command output for `SHOW DATABASES`.

You can also launch the Admin Dashboard for a GUI experience using the Admin Dashboard shortcut.  This will open your browser pointing at the local Admin Dashboard and automatically connect to your local InfluxDB instance if it is running.

![](/img/blog/windows/image18.png)

### Installing Telegraf

Telegraf is an agent written in Go for collecting metrics from the system it's running on, or from other services, and writing them into InfluxDB.  Currently, not all metrics collections are supported in this build, and is not feature complete on Windows.  We would love pull requests though, so feel free to add your own plugins or add support for the remaining features.

![](/img/blog/windows/image08.png)

![](/img/blog/windows/image11.png)

![](/img/blog/windows/image06.png)

After the installation you will see a new folder in your Startup Menu called “Telegraf”.  The following shortcuts are installed for your convenience:

* Telegraf Server - Launches the Telegraf collection service.
* Documentation - Links to the online documentation for Telegraf.

![](/img/blog/windows/image04.png)

Launching the Telegraf Server will bring up the following screen:

![](/img/blog/windows/image02.png)

If InfluxDB is already running on your computer, it will begin sending metrics it is collecting to your InfluxDB server.

### Installing Chronograf

Chronograf is a single binary web application for ad hoc exploration of your time series data in InfluxDB.

![](/img/blog/windows/image00.png)

![](/img/blog/windows/image03.png)

![](/img/blog/windows/image01.png)

After the installation you will see a new folder in your Startup Menu called “Chronograf”.  The following shortcuts are installed for your convenience:

* Chronograf Server - Launches the Chronograf collection service.
* Chronograf Dashboard - Opens the local Chronograf Dashboard.
* Documentation - Links to the online documentation for Chronograf.

![](/img/blog/windows/image09.png)

Launching the Chronograf Server will result in the following screen:

![](/img/blog/windows/image05.png)

Launching the Chronograf Dashboard will open a browser.  If you have not registered with [Influxdata](https://enterprise.influxdata.com/) yet, you will be promoted to sign up before you can use Chronograf.

![](/img/blog/windows/image16.png)

After completing the signup, you will be redirected to your local dashboard.  You will first be prompted to add your local server.  You can accept all the default options.

After adding a server, click on the graph icon on the left and begin building out your queries.  You can auto refresh the screen by selecting the refresh interval from the top right corner.

![](/img/blog/windows/image12.png)

### What’s next?

* Get the official [Windows Installer](https://influxdb.com/download/)
* Report back any bugs, enhancements or feedback on GitHub you have with the [installer](https://github.com/influxdb/windows-packager), [InfluxDB](https://github.com/influxdb/influxdb) or [Telegraf](https://github.com/influxdb/telegraf).


