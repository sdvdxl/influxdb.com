> **This repo is no longer in use.** The new site ([influxdata.com](https://influxdata.com)) has a different docs site ([docs.influxdata.com](https://docs.influxdata.com)), which lives at [influxdb/docs.influxdata.com](https://github.com/influxdb/docs.influxdata.com). Please open pull requests and issues there!

# InfluxDB.com 

This repository is the entire site at [influxdb.com](http://influxdb.com).

All of the publicly-available InfluxDB docs will live here.

## Contributing

See something that's incorrect? Send us a pull request!

* [Install Hugo](http://gohugo.io/overview/installing/)
* Fork this repository on Github
* Clone the repo to your local computer
```bash
git clone https://github.com/your_username/influxdb.com.git
cd influxdb.com/
```
* Make sweet edits
* Make sure the site compiles locally with `hugo server --watch`
* Check it at [localhost:1313](http://localhost:1313/)
* Submit a pull request
* Earn the respect, admiration, and eternal love of the entire InfluxDB community

## Deploying to S3

If you have the correct S3 credentials, you can easily push changes to the site. There's a script called `publish.sh` that will quickly deploy and synchronize the correct set of files from `master`.

### Install Dependencies

#### s3cmd

The `publish.sh` script uses a package called `s3cmd`, which you'll need to install first:

If you're using OSX:

```
brew install s3cmd
s3cmd --configure
```

Or, if you're using Ubuntu:

```
apt-get install s3cmd
s3cmd --configure
```

You'll then be prompted to set up the S3 credentials - you can get these from Gunnar, Regan, or Todd.

#### hugo

If you don't already have [Hugo](https://github.com/spf13/hugo) installed, you can install it via Homebrew by doing:

```
brew install hugo
```

Or build it from `master` by doing:

```
go get github.com/spf13/hugo
```

Just make sure the `hugo` binary is in your `PATH` before running the script.

### Publishing Changes

When you execute `publish.sh`, it will generate a new copy of the site in the `deploy` directory, to ensure that you don't have a collision with changes in the default `public` directory. It will then deploy all of the changes directly to the bucket. *The CloudFront invalidation will automatically be triggered after the files are synchronized.*

If you see any errors, double check that you'd supplied the correct S3 credentials and that both the `s3cmd` and `hugo` binaries are in your `PATH`.

