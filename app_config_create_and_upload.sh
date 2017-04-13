#!/usr/bin/env bash

# I expect the following directory structure:
#
# ./
#   |- dockerrunjsons/
#                    |- <version0>/
#                    |         |- Dockerrun.aws.json
#                    |- <version1>/
#                              |- Dockerrun.aws.json

if [ "$2" == "" ]; then
  cat <<EOF

USAGE:    $(basename $0) <version-name> <docker-image-tag>
EXAMPLE:  $(basename $0) latest latest

Will create the Dockerrun.aws.json file from the file dockerrun.json.template,
use the image 'flypenguin/test:latest', upload it to the S3 bucket '$S3_BUCKET',
and create a terraform file which creates the app version under the name
'latest'.

NOTE: flypenguin/test has only one version tag, which is 'latest'. So for your
own tests you'd need to modify the template.

EOF
  exit -1
fi

if [ "$EBS_BUCKET" == "" ] ; then
  echo ""
  echo "Enter S3 bucket to store config in. You can also set the EBS_BUCKET "
  echo "env variable to skip this question."
  echo "DO NOT USE THE 's3://' PREFIX, just the raw bucket name!"
  echo -n "S3 bucket: "
  read EBS_BUCKET
  echo ""
fi

#set -x

# enable sub-paths in S3
VERSION=$(basename $1)
cat app_config_json.template \
  | sed -r -e "s/%%IMAGE_TAG%%/$2/g" \
  > Dockerrun.aws.json
zip $VERSION Dockerrun.aws.json

# upload the shit

aws s3 cp $VERSION.zip s3://$EBS_BUCKET/$1.zip
rm -f $VERSION.zip
rm -f Dockerrun.aws.json

# create the terraform config

cat app_config_terraform.template \
  | sed -r -e "s/%%VERSION%%/$VERSION/g" \
           -e "s/%%EBS_BUCKET%%/$EBS_BUCKET/g" \
           -e "s!%%KEY%%!$1.zip!g" \
  > app_version_${VERSION}.tf

# done.
