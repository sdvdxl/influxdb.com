+++
title = "Chronograf"
layout = "chronograf-download"
+++

##  Installing Chronograf v0.2.0

Installing Chronograf on either a Debian/Ubuntu or RedHat/CentOS distribution of Linux is easy. Just choose the correct package for your platform:

### Ubuntu & Debian

- 64-bit system instructions

		wget https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf_0.2.0_amd64.deb
		sudo dpkg -i chronograf_0.2.0_amd64.deb

### RedHat & CentOS

- 64-bit system instructions

		wget https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf-0.2.0-1.x86_64.rpm
		sudo yum localinstall chronograf-0.2.0-1.x86_64.rpm

# Usage

If you installed Chronograf via a .deb or .rpm package, you should be able to simply run `sudo service chronograf start`.
The Chronograf startup script needs root permission to ensure that it can write to /var/log, but the actual executable runs as a normal user.

If you did not install Chronograf via a package, you can just directly run the executable, e.g. `/opt/chronograf/chronograf`.

# Contact Us

For questions about Chronograf, contact us at [support@influxdb.com](mailto:support@influxdb.com?subject=Chronograf Support).
