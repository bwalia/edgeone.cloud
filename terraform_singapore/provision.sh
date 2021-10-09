#!/bin/bash

set -x

workDir=/Users/balinderwalia/Documents/Work/edgeone/terraform_singapore

echo $workDir

cd /Users/balinderwalia/Documents/Work/go/go-services-manager/

./build.sh

cd $workDir

echo $pwd

export AWS_SDK_LOAD_CONFIG=1

echo "Provisioning edgeone default tenant infra..."

if [ -z ${AWS_PROFILE} ];
then
  AWS_PROFILE=default
fi

if [ -z ${AWS_REGION} ];
then
  AWS_REGION=ap-southeast-1
fi

/usr/local/bin/terraform import aws_vpc.prod-vpc vpc-0b4b20c60a0bb76fb

/usr/local/bin/terraform init

#terraform plan

/usr/local/bin/terraform apply --auto-approve

#/bin/bash update-dynomite.sh
