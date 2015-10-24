#!/bin/bash
#
# Push the updated site to s3 from master. 
#
# This expects (and does NOT check for) s3cmd to be installed and configured!
# This expects (and does NOT check for) hugo to be installed and on your $PATH.
# You still need to manually create a Cloudfront invalidation when this script finishes.

bucket='influxdb.com'

branch=$(git rev-parse --abbrev-ref HEAD)

if [[ "$branch" == "master" ]]; then
  rm -rf deploy
  hugo -d deploy --config=config-production.toml
  echo "Syncing deploy/* with s3://$bucket"
  find . -name '*.DS_Store' -type f -delete
  s3cmd --acl-public --delete-removed --no-progress sync deploy/* s3://$bucket
  echo -e "\nUpdated s3://$bucket"
else
  echo "*** s3://$bucket only gets synced from master! ***"
fi
          
exit 0
