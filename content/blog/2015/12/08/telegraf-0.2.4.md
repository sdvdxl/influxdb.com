# Announcing Telegraf 0.2.4 with our First 3rd-Party API Support: MailChimp!

[MailChimp](http://mailchimp.com/) is an email-marketing platform that provides
a robust JSON API of
metrics on email campaigns. Since Telegraf can make HTTP API calls and parse
JSON, it was a natural step to allow Telegraf to parse data from services that
provide metrics via an API key.

The MailChimp API provides many metrics such as `emails_sent`,
`clicks_total`, and `open_rate` for all email campaigns via their `/reports`
API. More details on the available MailChimp metrics are documented on the
[MailChimp website.](http://developer.mailchimp.com/documentation/mailchimp/reference/reports/#read-get_reports)

With [Telegraf 0.2.4](https://github.com/influxdb/telegraf), you can now setup
the `mailchimp` plugin to gather metrics
and forward those onto InfluxDB or any other configured output sink. Below is a
full configuration example that will collect MailChimp metrics and send them
to a local InfluxDB instance.

```toml
# Configuration for telegraf agent
[agent]
  # Default data collection interval for all plugins
  interval = "30s"

###############################################################################
#                                  OUTPUTS                                    #
###############################################################################

[outputs]

# Configuration for influxdb server to send metrics to
[[outputs.influxdb]]
  # The full HTTP or UDP endpoint URL for your InfluxDB instance.
  urls = ["http://localhost:8086"] # required
  # The target database for metrics (telegraf will create it if not exists)
  database = "telegraf" # required
  # Precision of writes, valid values are n, u, ms, s, m, and h
  # note: using second precision greatly helps InfluxDB compression
  precision = "s"

###############################################################################
#                                  PLUGINS                                    #
###############################################################################

[plugins]

# Gathers metrics from the /3.0/reports MailChimp API
[[plugins.mailchimp]]
  # MailChimp API key
  # get from https://admin.mailchimp.com/account/api/
  api_key = "" # INSERT API KEY HERE
  # Reports for campaigns sent more than days_old ago will not be collected.
  # 0 means collect all.
  days_old = 14
```

The configuration above is using the `days_old = 14` argument to tell Telegraf
to only collect metrics on email campaigns that were sent in the past 14 days. If
you set this to 0, it will collect metrics for all email campaigns.

Paste the above into a file of your choice (I'll use `~/telegraf.conf`) and
insert your
[MailChimp API Key](https://admin.mailchimp.com/account/api/) and run a test
output, which will output your MailChimp metrics converted into the
[InfluxDB line protocol format.](https://influxdb.com/docs/v0.9/write_protocols/line.html)

```bash
$ telegraf -config ~/telegraf.conf -test
* Plugin: mailchimp, Collection 1
> mailchimp_emails_sent,campaign_title=MyCampaign,id=1aa2bb34c5 value=7640i 1449103122757261374
> mailchimp_abuse_reports,campaign_title=MyCampaign,id=1aa2bb34c5 value=0i 1449103122757261374
> mailchimp_unsubscribed,campaign_title=MyCampaign,id=1aa2bb34c5 value=38i 1449103122757261374
> mailchimp_hard_bounces,campaign_title=MyCampaign,id=1aa2bb34c5 value=38i 1449103122757261374
> mailchimp_soft_bounces,campaign_title=MyCampaign,id=1aa2bb34c5 value=71i 1449103122757261374
> mailchimp_syntax_errors,campaign_title=MyCampaign,id=1aa2bb34c5 value=0i 1449103122757261374
[...]
```

You can see from the output that the plugin will collect available metrics for
each campaign, as well as collecting the industry and list stats metrics.

Telegraf can now be run and start outputting it's metrics
to InfluxDB: `$ telegraf -config ~/telegraf.conf`

### Future Work:

MailChimp is just the first of many 3rd-party APIs that we plan on supporting in
Telegraf. Users are encouraged to try their hand at
[contributing a plugin](https://github.com/influxdb/telegraf/blob/master/CONTRIBUTING.md#plugins),
and we plan to support
[AWS Metrics](https://github.com/influxdb/telegraf/issues/346) soon.

You can view the source for the MailChimp plugin
[here](https://github.com/influxdb/telegraf/tree/master/plugins/mailchimp)

------

[Cameron Sparr](https://github.com/sparrc) works for Influx Data and is the
maintainer of [Telegraf](https://github.com/influxdb/telegraf)
