---
title: Deploying InfluxDB with Ansible
author: Ross McDonald
date: 2015-11-19
publishdate: 2015-11-19
---

Today we will cover how to deploy and configure an instance of the time-series database InfluxDB using Ansible.

### Why Ansible?

Out of all of the configuration management tools out there, why use [Ansible](http://www.ansible.com/)? The answer, at least for me, has always been simplicity. Ansible is an ‘agentless’ configuration management tool, which is to say that it requires zero dependencies to be installed on the target machines prior to getting started. Ansible uses a widely-used, secure communication protocol called SSH (Secure SHell) to execute commands remotely in parallel. This makes Ansible unique in that the only thing stopping you from deploying an Ansible “task” (or “playbook”) to any server is simply an SSH connection and Ansible itself (installation instructions [here](http://docs.ansible.com/ansible/intro_installation.html#getting-ansible)). Ansible playbooks are also written in a data-serialization format called [YAML](https://en.wikipedia.org/wiki/YAML) (a superset of JSON), so you don’t have to learn any new languages to get started.

### Why InfluxDB?

[InfluxDB](https://influxdb.com/) is a zero-dependency time series database that strikes the near-perfect balance between ease-of-use and power. With language support for Erlang, Go, Haskell, Python, Java, PHP, and more, it is hard to not find a reason to use InfluxDB for your time series data.

### Getting Started

The building block of any Ansible deployment is the ‘task’ file. This file enumerates all of the steps that you will want Ansible to perform in order to configure your server. Ansible also has the concept of a “playbook” (similar to a project), but that is a bit outside the scope of this article.

In order to install and configure InfluxDB, we will need to perform the following steps:

1. Setup the InfluxDB repository
2. Install InfluxDB
3. Configure InfluxDB
4. [optional] Any post-configuration steps required - This can include creating databases, loading sample data, or any other steps required before using the database.

*For the remainder of this article, we will assume that we are using an Ubuntu 14.04 server with an Ansible version >= 1.6. The task/playbook we will be creating is available for download [here](https://github.com/rossmcdonald/influxdb-ansible-blog).*

### Setting up the InfluxDB Repository

To start off, we will need to setup the InfluxDB repository, which is currently hosted at [repos.influxdata.com](https://repos.influxdata.com). The first step when adding a repository to the APT package manager is to add the GPG signing key from the package maintainers. This ensures that the packages are verified to be secure. This task will look like:

```
- name: Import InfluxDB GPG signing key
  apt_key: url=https://repos.influxdata.com/influxdb.key state=present
```

Where the `-name` attribute is simply a human-readable declaration of what this task is supposed to accomplish. The `apt_key` on the line below is the invocation of Ansible’s built-in [`apt_key`](http://docs.ansible.com/ansible/apt_key_module.html) module, which adds GPG keys to the Ubuntu package manager configuration. The module takes two parameters: a `url` field (the URL to the key we want to add) and a `state` field (what the status of the key should be once the task is completed, in this case `present` since we are adding it to our current configuration).

Once the GPG signing key is added, we will then need to add the repository to our configuration:

```
- name: Add InfluxDB repository
  apt_repository: repo='deb https://repos.influxdata.com/ubuntu trusty stable' state=present
```
  
Here we are stating that we would like to use the https://repos.influxdata.com/ubuntu repository (leveraging the [`apt_repository`](http://docs.ansible.com/ansible/apt_repository_module.html) module). The `trusty` towards the end of the line is referring to the codename of the current Ubuntu release (Trusty Tahr), and the `stable` is referring to the package channel we would like to use. The InfluxDB repository currently supports a stable and unstable package channel. 

### Installing InfluxDB

Now that our repository is added to the system package manager, it is time to install InfluxDB:

```
- name: Install InfluxDB packages
  apt: name=influxdb state=present
```

This time we are using the [`apt`](http://docs.ansible.com/ansible/apt_module.html) module, where the `name` refers to the package name we want to install, and `state` refers to the status of the package (`present` meaning don’t upgrade if it’s already installed). Once the above task has completed, we now know that InfluxDB was successfully installed.

### Configuring and Starting InfluxDB

Now that we’ve installed InfluxDB, let's modify the configuration a bit. By default, the InfluxDB hostname points to `localhost`. Let’s change that:

```
- name: Modify InfluxDB hostname
  replace:
    dest=/etc/opt/influxdb/influxdb.conf
    regexp='hostname = "localhost"'
    replace='hostname = "{{ ansible_hostname }}"'
    backup=yes
```

Here we are using the [`replace`](http://docs.ansible.com/ansible/replace_module.html) module to replace all instances of the `hostname = “localhost”` string with the new and improved `hostname = “{{ ansible_hostname }}”` string in the InfluxDB configuration, where, at runtime, the `{{ ansible_hostname }}` string will be converted to your server's real hostname (leveraging the power of [Jinja2](http://jinja.pocoo.org/docs/dev/)). The `dest` signifies the file we would like to modify, and by using the `backup=yes` flag we are also ensuring backup of the current configuration is made, just in case anything goes awry.

Wait, we just modified the configuration without restarting the service! The new changes won’t take effect until the service is restarted, so let’s do that now:

```
- name: Start the InfluxDB service
  service: name=influxdb state=restarted
```

Here we are using the [`service`](http://docs.ansible.com/ansible/service_module.html) module to restart the InfluxDB service.

*Note: restarting the service on every run is typically not something we want to do (especially if the configuration didn't even change). We are just using basic tasks for this post, but, as a best-practice, it is recommended to utilize a [Handler](http://docs.ansible.com/ansible/playbooks_intro.html#handlers) to make sure a service restart is only executed when the configuration changes.*

### Loading Some Test Data

By combining the above building blocks, we now have a fully-functioning instance of InfluxDB ready and waiting. One thing that we left out was the post-configuration step described in our list above. While not absolutely mandatory, having a shiny new InfluxDB instance isn’t as exciting if there isn’t some test data ready for us to play with. Let’s create a test database and add some random points:

```
- name: Create sample database
  command: /opt/influxdb/influx -execute 'CREATE DATABASE sample_database'

- name: Load some test data into sample database
  uri:
    url: https://localhost:8086/write?db=sample_database
    method: POST
    body: "random_ints,host=server_{{ 10 | random }} value={{ 100 | random }}"
    status_code: 204
  with_sequence: start=1 end=10
```

The above is left as an exercise for the reader to decipher. Here are a few links to get you started:

* [command module](http://docs.ansible.com/ansible/command_module.html)
* [Using the Influx Shell](https://influxdb.com/docs/v0.9/tools/shell.html)
* [uri](http://docs.ansible.com/ansible/uri_module.html) module
* [with_sequence](http://docs.ansible.com/ansible/playbooks_loops.html#looping-over-integer-sequences) looping
* [random filter](http://docs.ansible.com/ansible/playbooks_filters.html#random-number-filter)

There is one last step before we can run our new playbook: we have to tell Ansible which server to install InfluxDB on. To do this, we’ll need to create an ‘[inventory](http://docs.ansible.com/ansible/intro_inventory.html)’ file. This file will simply be a listing of each server we want to run our playbook on. This will vary by your environment, but will resemble the following:

```
ubuntu@influxdb.mydomain.com
```

Where `ubuntu` is the username you would like to use to authenticate, and `influxdb.mydomain.com` is the DNS-resolvable hostname to your server (assuming you already have SSH access). Write this to a file (`hosts`, for example), and we’re all set!

Now that we have the pieces necessary to get everything installed, all we need to do is write them to a file (install-influxdb.yml, for example) and have Ansible do the heavy-lifting for us. The exact shell command will vary by your setup, but it is usually of the form:

```
$ ansible-playbook -i hosts install-influxdb.yml
```

If everything worked as expected, you should have seen something similar to the following output:

```
PLAY [all] ********************************************************************

GATHERING FACTS ***************************************************************
ok: [influx1]

TASK: [Import InfluxDB GPG signing key] ***************************************
changed: [influx1]

TASK: [Add InfluxDB repository] ***********************************************
changed: [influx1]

TASK: [Install InfluxDB packages] *********************************************
changed: [influx1]

TASK: [Modify InfluxDB hostname] **********************************************
changed: [influx1]

TASK: [Start the InfluxDB service] ********************************************
changed: [influx1]

TASK: [Pause for InfluxDB service] ********************************************
(^C-c = continue early, ^C-a = abort)
[influx1]
Pausing for 3 seconds
ok: [influx1]

TASK: [Create sample database] ************************************************
changed: [influx1]

TASK: [Load some test data into sample database] ******************************
ok: [influx1] => (item=1)
ok: [influx1] => (item=2)
ok: [influx1] => (item=3)
ok: [influx1] => (item=4)
ok: [influx1] => (item=5)
ok: [influx1] => (item=6)
ok: [influx1] => (item=7)
ok: [influx1] => (item=8)
ok: [influx1] => (item=9)
ok: [influx1] => (item=10)

PLAY RECAP ********************************************************************
influx1                    : ok=9    changed=6    unreachable=0    failed=0
```

*Note: `influx1` is the hostname of my local VM, so you should expect to see something different*

You now have a fully functioning (and, more importantly, easily reproducible) InfluxDB instance with some test data to play around with. The full task file used to run this Ansible playbook is available [here](https://github.com/rossmcdonald/influxdb-ansible-blog/blob/master/install-influxdb.yml).
